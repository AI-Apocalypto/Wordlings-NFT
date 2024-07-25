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

        address _entropy = 0x5744Cbf430D99456a0A8771208b674F27f8EF0Fb; // blast mainnet address

        address _provider = 0x52DeaA1c84233F7bb8C8A45baeDE41091c616506; // provider for mainnetxs

        WordlingsNFT nft = new WordlingsNFT(_owner, _entropy, _provider);

        vm.stopBroadcast();
    }
}
