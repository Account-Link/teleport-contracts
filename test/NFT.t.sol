// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/NFT.sol";

contract NFTTest is Test {
    NFT public nft;
    address public owner = address(1);
    address public minter = address(2);
    address public recipient = address(3);

    function setUp() public {
        vm.startPrank(owner);
        nft = new NFT("TestNFT", "TNFT", owner);
        nft.whitelistMinter(minter);
        vm.stopPrank();
    }

    function testTokenURI() public {
        uint256 x_id = 12345;
        string memory policy = "Be respectful and kind";
        string memory username = "testuser";
        string memory pfp = "https://example.com/pfp.jpg";
        string memory name = "Test User";

        vm.prank(minter);
        uint256 tokenId = nft.mintTo(
            recipient,
            x_id,
            policy,
            name,
            username,
            pfp,
            keccak256("asdf"),
            1
        );

        string memory uri = nft.tokenURI(tokenId);

        assertEq(nft.nftIdMap(keccak256("asdf")), 1);

        // Print out the URI
        console.log("Token URI:", uri);
    }
}
