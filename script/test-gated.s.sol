
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/GatedNFTBatchRedeem.sol";
import "../src/NFT.sol";


contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address owner = 0x36e7Fda8CC503D5Ec7729A42eb86EF02Af315Bf9;
        // address owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

        // NFT nft = new NFT("Account.link - test", "account.link - test", "https://account.link/metadata/", owner);

        // nft.whitelistMinter(owner);
        NFT nft = NFT(0x80c6E67D2dD57d56B89561Eb85Bc48ba12d609Fc);

        GatedNFTBatchRedeem batchR = new GatedNFTBatchRedeem(
            address(nft)
        );

        nft.mintTo(address(batchR), 1, "everything");
        nft.mintTo(address(batchR), 2, "everything");
        nft.mintTo(address(batchR), 3, "everything");
        nft.mintTo(address(batchR), 4, "everything");
        nft.mintTo(address(batchR), 5, "everything");

        uint256[] memory tokenIds = new uint256[](5);
        tokenIds[0] = 1;
        tokenIds[1] = 2;
        tokenIds[2] = 3;
        tokenIds[3] = 4;
        tokenIds[4] = 5;

        batchR.redeem(tokenIds, "I'm fat");

        vm.stopBroadcast();
    }
}
