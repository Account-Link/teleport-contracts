// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NFT.sol";

contract GatedNFTBatchRedeem is ERC721Holder, Ownable {
    NFT nft;

    constructor(address _nft) Ownable(msg.sender) {
        nft = NFT(_nft);
    }

    function redeem(
        uint256[] calldata tokenIds,
        string memory content
    ) public onlyOwner {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            nft.redeem(tokenIds[i], content, NFT.TokenType.TWEET);
        }
    }
}
