pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address minter = 0x8DA7e42D1800eDd66F0cefA21c0c67A65CC72A74;
        vm.startBroadcast(deployerPrivateKey);
        NFT nft = new NFT("Account.link", "account.link", minter);
        nft.whitelistMinter(minter);
        vm.stopBroadcast();
    }
}
