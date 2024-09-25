// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {
    using Strings for uint256;

    error NonExistentTokenURI();

    enum TokenType {
        TWEET,
        LIKE
    }

    struct TokenData {
        uint256 x_id;
        string policy;
    }

    // Mapping from token ID to its data
    mapping(uint256 => TokenData) private tokenDataMap;

    // Whitelisted addresses
    mapping(address => bool) public isWhitelisted;

    // Event emitted on top of `ERC20::Transfer` for granularity & indexer data availability
    event NewTokenData(
        uint256 indexed tokenId,
        uint256 indexed x_id,
        address to,
        string policy
    );
    // Event to be emitted upon redemption of a tweet
    event RedeemTweet(
        uint256 indexed tokenId,
        uint256 indexed x_id,
        string policy,
        string content
    );
    // Event to be emitted upon redemption of a tweet like
    event RedeemLike(
        uint256 indexed tokenId,
        uint256 indexed x_id,
        string policy,
        string tweetId
    );
    // Event to be emitted upon whitelisting of a minter
    event WhitelistMinter(address indexed minter);
    // Event to be emitted upon removing a minter
    event RemoveMinter(address indexed minter);

    string public baseURI;
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI,
        address initialOwner
    ) ERC721(_name, _symbol) Ownable(initialOwner) {
        baseURI = _baseURI;
    }

    function whitelistMinter(address minter) public onlyOwner {
        isWhitelisted[minter] = true;
        emit WhitelistMinter(minter);
    }

    function removeMinter(address minter) public onlyOwner {
        isWhitelisted[minter] = false;
        emit RemoveMinter(minter);
    }

    function mintTo(
        address recipient,
        uint256 x_id,
        string memory policy
    ) public returns (uint256) {
        require(isWhitelisted[msg.sender], "Caller is not whitelisted");
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);

        tokenDataMap[newTokenId] = TokenData(x_id, policy);

        emit NewTokenData(newTokenId, x_id, recipient, policy);

        return newTokenId;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert NonExistentTokenURI();
        }
        return
            bytes(baseURI).length > 0
                ? string.concat(baseURI, tokenId.toString())
                : "";
    }

    // Redeem function that emits an event
    function redeem(
        uint256 tokenId,
        string memory content,
        TokenType tokenType
    ) public {
        require(
            ownerOf(tokenId) == msg.sender || isWhitelisted[msg.sender],
            "Caller is not the token owner or the contract owner"
        );

        TokenData memory data = tokenDataMap[tokenId];

        // emit RedeemTweet(tokenId, data.x_id, data.policy, content);
        if (tokenType == TokenType.TWEET) {
            emit RedeemTweet(tokenId, data.x_id, data.policy, content);
        } else if (tokenType == TokenType.LIKE) {
            emit RedeemLike(tokenId, data.x_id, data.policy, content);
        } else {
            revert("Invalid token type");
        }

        // burn NFT
        _burn(tokenId);
    }
}
