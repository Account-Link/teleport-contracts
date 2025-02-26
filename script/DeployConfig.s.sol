// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";

contract DeployConfig is Script {
    struct NetworkConfig {
        string name;
        string symbol;
        address[] initialWhitelist;
    }

    function getConfig() external view returns (NetworkConfig memory) {
        // Default config
        address[] memory whitelist = new address[](1);
        whitelist[0] = vm.addr(vm.envUint("PRIVATE_KEY")); // Add deployer to whitelist

        return NetworkConfig({
            name: "GitHub Repository Token",
            symbol: "REPO",
            initialWhitelist: whitelist
        });
    }
} 