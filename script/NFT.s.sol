pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        NFT nft = new NFT(
            "Account.link",
            "account.link",
            "https://account.link/metadata/",
            address(0x36e7Fda8CC503D5Ec7729A42eb86EF02Af315Bf9)
        );

        vm.stopBroadcast();
    }
}
