pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NFTBatchRedeem.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        NFTBatchRedeem nftBatchRedeem = NFTBatchRedeem(
            0x0b33bd59FCa63390A341ee6f608Bf5Ed1393ffcc
        );

        uint256[] memory nftIds = _nftIds();

        vm.startBroadcast(deployerPrivateKey);
        nftBatchRedeem.redeem(nftIds, "");
        vm.stopBroadcast();
    }

    function _nftIds() public pure returns (uint256[] memory) {
        uint256[] memory nftIds = new uint256[](647);
        uint64 idx = 0;
        for (uint256 i = 873; i < 1523; i++) {
            if (i == 973 || i == 974) {
                continue;
            }
            nftIds[idx++] = i;
        }
    }
}
