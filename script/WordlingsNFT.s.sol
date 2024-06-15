// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/WordlingsNFT.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address _owner = 0x9131659d334558138548b128E3Ac7557212B5Efe;

        address _entropy = 0x549Ebba8036Ab746611B4fFA1423eb0A4Df61440;

        address _provider = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;

        address proxy = Upgrades.deployUUPSProxy(
            "WordlingsNFT.sol",
            abi.encodeCall(WordlingsNFT.initialize, (_owner, _entropy, _provider))
        );
        vm.stopBroadcast();
    }
}
