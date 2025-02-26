// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {RepoToken} from "../src/RepoToken.sol";

contract DeployRepoToken is Script {
    function run() external returns (RepoToken) {
        // Get deployment configuration
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        string memory rpcUrl = vm.envString("BASE_RPC_URL");
        
        // Configure the network
        vm.createSelectFork(rpcUrl);
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy RepoToken contract
        RepoToken repoToken = new RepoToken(
            "Github Repo NFT", // name
            "REPO"            // symbol
        );

        // Optional: Whitelist the deployer address
        repoToken.whitelistMinter(vm.addr(deployerPrivateKey));

        vm.stopBroadcast();

        return repoToken;
    }
} 