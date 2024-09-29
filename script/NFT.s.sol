pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address minter = 0xA4D75b152D56D703D46B5a2c37096B3eCb06C7FD;
        vm.startBroadcast(deployerPrivateKey);

        NFT nft = new NFT(
            "Account.link",
            "account.link",
            "https://account.link/metadata/",
            minter
        );

        nft.whitelistMinter(minter);

        vm.stopBroadcast();
    }
}
