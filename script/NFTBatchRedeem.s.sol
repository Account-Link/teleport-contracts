pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NFTBatchRedeem.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        new NFTBatchRedeem(address(0xC8bBb02015a096F099DedA4eAD138c1Db069cd98));

        vm.stopBroadcast();
    }
}
