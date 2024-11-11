// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFT is ERC721, Ownable {
    using Strings for uint256;

    error NonExistentTokenURI();

    enum TokenType {
        TWEET,
        LIKE
    }

    struct TokenData {
        uint256 x_id;
        address addr;
        string policy;
        string name;
        string username;
        string pfp;
        uint256 tweetTime;
    }

    // Mapping from Hash(nftId) to token ID
    mapping(bytes32 => uint256) public nftIdMap;

    // Mapping from token ID to its data
    mapping(uint256 => TokenData) private tokenDataMap;

    // Whitelisted addresses
    mapping(address => bool) public isWhitelisted;

    // Event emitted on top of `ERC20::Transfer` for granularity & indexer data availability
    event NewTokenData(
        uint256 indexed tokenId,
        uint256 indexed x_id,
        address to,
        string policy,
        string name,
        string username,
        string pfp,
        uint256 tweetTime
    );
    // Event to be emitted upon redemption of a tweet
    event RedeemTweet(
        uint256 indexed tokenId,
        uint256 indexed x_id,
        address addr,
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
    // Event to be emitted upon updating tweet time
    event TweetTimeUpdated(
        uint256 indexed tokenId,
        uint256 oldTweetTime,
        uint256 newTweetTime
    );

    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol,
        address initialOwner
    ) ERC721(_name, _symbol) Ownable(initialOwner) {}

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
        string memory policy,
        string memory name,
        string memory username,
        string memory pfp,
        bytes32 nftIdHash,
        uint256 usesLeft
    ) public returns (uint256) {
        require(isWhitelisted[msg.sender], "Caller is not whitelisted");
        require(nftIdMap[nftIdHash] == 0);
        require(usesLeft > 0, "Uses left is 0");
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);

        tokenDataMap[newTokenId] = TokenData(
            x_id,
            recipient,
            policy,
            name,
            username,
            pfp,
            usesLeft
        );

        nftIdMap[nftIdHash] = newTokenId;

        emit NewTokenData(
            newTokenId,
            x_id,
            recipient,
            policy,
            name,
            username,
            pfp,
            usesLeft
        );

        return newTokenId;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert NonExistentTokenURI();
        }
        // return
        //     bytes(baseURI).length > 0
        //         ? string.concat(baseURI, tokenId.toString())
        //         : "";

        TokenData memory data = tokenDataMap[tokenId];

        string memory name = string(
            abi.encodePacked("Teleport to ", data.username)
        );

        string memory description = string(
            abi.encodePacked(
                "Allows you to post once from ",
                data.username,
                "'s account if your post passes the following check by the LLM: ",
                "'",
                data.policy,
                "'"
            )
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"description": "',
                        description,
                        '", "image": "',
                        data.pfp,
                        '", "name": "',
                        name,
                        '", "attributes": [{"trait_type": "X Username", "value": "',
                        data.username,
                        '"}, {"trait_type": "LLM safeguard", "value": "',
                        data.policy,
                        '"}, {"trait_type": "Tweet Time Left", "value": "',
                        data.tweetTime,
                        '"}, {"trait_type": "X Name", "value": "',
                        data.name,
                        '"}]}'
                    )
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
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

        TokenData storage data = tokenDataMap[tokenId];

        require(data.tweetTime > 0, "Uses left is 0");

        // emit RedeemTweet(tokenId, data.x_id, data.policy, content);
        if (tokenType == TokenType.TWEET) {
            emit RedeemTweet(
                tokenId,
                data.x_id,
                data.addr,
                data.policy,
                content
            );
        } else if (tokenType == TokenType.LIKE) {
            emit RedeemLike(tokenId, data.x_id, data.policy, content);
        } else {
            revert("Invalid token type");
        }

        // update uses left
        data.tweetTime--;

        if (data.tweetTime == 0) {
            // burn NFT
            _burn(tokenId);
        }
    }

    function addTweetTime(uint256 tokenId, uint256 time) public {
        require(isWhitelisted[msg.sender], "Caller is not the contract owner");
        TokenData storage data = tokenDataMap[tokenId];
        uint256 oldTweetTime = data.tweetTime;
        data.tweetTime += time;
        emit TweetTimeUpdated(tokenId, oldTweetTime, data.tweetTime);
    }
}
