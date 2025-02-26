// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

/**
 * @title RepoToken
 * @notice An ERC721 token representing ownership or claim of a GitHub repository.
 *         Minted tokens can be redeemed (burned) after a successful repository transfer.
 *         Includes 5% creator royalties on secondary sales.
 */
contract RepoToken is ERC721URIStorage, Ownable, ERC2981 {
    using Strings for uint256;

    struct TokenData {
        string githubUsername;  // e.g., "alice"
        string repoName;        // e.g., "my-awesome-repo"
        string repoDescription; // e.g., "description of the repo (about)"
        string appLink;         // e.g., "awesome-app.com"
        address holderAddress;  // current holder of the token
        string displayName;     // Name of the repo app
        string imageUrl;        // optional: repo image or user avatar
    }

    // Mapping from GitHub username + repo name to token ID to prevent duplicates
    mapping(string => uint256) public repoTokenMap;

    // Mapping from token ID to its data
    mapping(uint256 => TokenData) private tokenDataMap;

    // Whitelisted addresses allowed to mint
    mapping(address => bool) public isWhitelisted;

    // Event emitted when a new repo token is minted
    event NewRepoToken(
        uint256 indexed tokenId,
        string githubUsername,
        string repoName,
        address to,
        string repoDescription,
        string displayName,
        string imageUrl
    );

    // Event emitted upon redeeming (burning) the repo token
    event RedeemRepo(
        uint256 indexed tokenId,
        string githubUsername,
        string repoName,
        address holderAddress,
        string repoDescription,
        string reason
    );

    // Event to be emitted upon whitelisting of a minter
    event WhitelistMinter(address indexed minter);

    // Event to be emitted upon removing a minter
    event RemoveMinter(address indexed minter);

    // Tracks the last used token ID
    uint256 public currentTokenId;

    // Royalty percentage (5% = 500 basis points)
    uint96 public constant ROYALTY_FEE_BASIS_POINTS = 500;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        // Set default royalty receiver to contract owner with 5% royalty
        _setDefaultRoyalty(msg.sender, ROYALTY_FEE_BASIS_POINTS);
    }

    // --- Whitelisting Logic ---

    function whitelistMinter(address minter) public onlyOwner {
        isWhitelisted[minter] = true;
        emit WhitelistMinter(minter);
    }

    function removeMinter(address minter) public onlyOwner {
        isWhitelisted[minter] = false;
        emit RemoveMinter(minter);
    }

    // --- Minting Logic ---

    /**
     * @dev Mints a new RepoToken for a GitHub repository.
     * @param recipient Address that will receive the newly minted token.
     * @param githubUsername GitHub username associated with the repo.
     * @param repoName The name of the repository.
     * @param repoDescription Description of the repository.
     * @param displayName Optional display name or short title.
     * @param imageUrl Optional image/URL (e.g., a repo or user avatar).
     * @param appLink Optional link to live application.
     */
    function mintRepoToken(
        address recipient,
        string memory githubUsername,
        string memory repoName,
        string memory repoDescription,
        string memory displayName,
        string memory imageUrl,
        string memory appLink
    ) public returns (uint256) {
        require(isWhitelisted[msg.sender], "Caller is not whitelisted");
        
        // Create a unique key for this repository
        string memory repoKey = string(abi.encodePacked(githubUsername, "/", repoName));
        require(repoTokenMap[repoKey] == 0, "Token already minted for this repository");

        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);

        // Store the token data
        tokenDataMap[newTokenId] = TokenData({
            githubUsername: githubUsername,
            repoName: repoName,
            repoDescription: repoDescription,
            appLink: appLink,
            holderAddress: recipient,
            displayName: displayName,
            imageUrl: imageUrl
        });

        // Mark the repository as tokenized
        repoTokenMap[repoKey] = newTokenId;

        // Generate and set token URI
        _setTokenURI(newTokenId, _generateTokenURI(newTokenId));

        emit NewRepoToken(
            newTokenId,
            githubUsername,
            repoName,
            recipient,
            repoDescription,
            displayName,
            imageUrl
        );

        return newTokenId;
    }

    // --- Token URI ---

    /**
     * @dev Generates a data URI with JSON metadata for the repo token.
     */
    function _generateTokenURI(uint256 tokenId) internal view returns (string memory) {
        TokenData memory data = tokenDataMap[tokenId];

        // Construct name and description
        string memory name = bytes(data.displayName).length > 0
            ? data.displayName
            : string(abi.encodePacked("Repo Token: ", data.githubUsername, "/", data.repoName));

        string memory description = string(
            abi.encodePacked(
                "A token representing the GitHub repository: ",
                data.githubUsername,
                "/",
                data.repoName,
                ". ",
                data.repoDescription
            )
        );

        // Build JSON metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name":"',
                        name,
                        '","description":"',
                        description,
                        '","image":"',
                        data.imageUrl,
                        '","external_url":"https://github.com/',
                        data.githubUsername,
                        '/',
                        data.repoName,
                        '","attributes":[',
                        '{"trait_type":"GitHub Username","value":"',
                        data.githubUsername,
                        '"},',
                        '{"trait_type":"Repository","value":"',
                        data.repoName,
                        '"},',
                        '{"trait_type":"App Link","value":"',
                        data.appLink,
                        '"}',
                        ']}'
                    )
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    // --- Redeeming (Burning) Logic ---

    /**
     * @dev Redeems (burns) the token, indicating the repo token is used (e.g., after transfer).
     * @param tokenId The ID of the token to redeem/burn.
     * @param reason A short note about why the token is redeemed (e.g., "Transfer completed").
     */
    function redeemRepo(
        uint256 tokenId,
        string memory reason
    ) public {
        require(
            ownerOf(tokenId) == msg.sender || isWhitelisted[msg.sender],
            "Caller is not the owner or whitelisted"
        );

        TokenData memory data = tokenDataMap[tokenId];

        emit RedeemRepo(
            tokenId,
            data.githubUsername,
            data.repoName,
            data.holderAddress,
            data.repoDescription,
            reason
        );

        // Clear the repo mapping to allow reminting if needed
        string memory repoKey = string(abi.encodePacked(data.githubUsername, "/", data.repoName));
        delete repoTokenMap[repoKey];
        
        // Remove token data
        delete tokenDataMap[tokenId];

        // Burn the NFT
        _burn(tokenId);
    }

    /**
     * @dev Returns token data for a given token ID
     */
    function getTokenData(uint256 tokenId) public view returns (
        string memory githubUsername,
        string memory repoName,
        string memory repoDescription,
        string memory appLink,
        address holderAddress,
        string memory displayName,
        string memory imageUrl
    ) {
        require(_exists(tokenId), "Token does not exist");
        TokenData memory data = tokenDataMap[tokenId];
        
        return (
            data.githubUsername,
            data.repoName,
            data.repoDescription,
            data.appLink,
            data.holderAddress,
            data.displayName,
            data.imageUrl
        );
    }

    /**
     * @dev Checks if a token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }

    /**
     * @dev Updates the royalty info for the contract
     * @param receiver Address that should receive royalties
     * @param feeNumerator The fee percentage (in basis points) for the royalties
     */
    function setDefaultRoyalty(address receiver, uint96 feeNumerator) external onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    /**
     * @dev Updates the royalty info for a specific token
     * @param tokenId The token to set royalties for
     * @param receiver Address that should receive royalties
     * @param feeNumerator The fee percentage (in basis points) for the royalties
     */
    function setTokenRoyalty(
        uint256 tokenId,
        address receiver,
        uint96 feeNumerator
    ) external onlyOwner {
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721URIStorage, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}