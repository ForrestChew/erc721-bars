// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {Item2} from "../src/Item2.sol";
import {ScriptConstants} from "./ScriptConstants.s.sol";

contract Item2Deployment is Script, ScriptConstants {
    function setUp() public {
        
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        Item2 item = new Item2("Item2", "ITEM2", "https://example.com/", ORE_MIRROR_BLAST_SEPOLIA);

        console.log("Item2 deployed at address: ", address(item));
        vm.stopBroadcast();
    }
}
