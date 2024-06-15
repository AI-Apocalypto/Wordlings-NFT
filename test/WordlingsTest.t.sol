// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {WordlingsNFT} from "../src/WordlingsNFT.sol";

import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract WordlingsTest is Test {
    WordlingsNFT public wordlings;
    address _owner = 0x9131659d334558138548b128E3Ac7557212B5Efe;

    address _entropy = 0x549Ebba8036Ab746611B4fFA1423eb0A4Df61440;

    address _provider = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;
    address payable _proxy;
    address _implementation;

    address public bob = address(0x23);
    address public alice = address(0x55);

    function setUp() public {
        address implementation = address(new WordlingsNFT());
        bytes memory data = abi.encodeCall(wordlings.initialize, (_owner, _entropy, _provider));
        address payable proxy = payable(address(new ERC1967Proxy(implementation, data)));
        _proxy = proxy;
        _implementation = implementation;

        wordlings = WordlingsNFT(_proxy);

    }

    function test_GameState() public {
        bool stat = wordlings.gameStarted();
        console.log("%s", stat);
    }
    
    function test_mintMysteryBox() public {
        vm.prank(_owner);
        wordlings.startGame();
        deal(bob, 10 ether);
        console.log("%s", bob.balance);
        
        vm.prank(bob);
        // bytes32 RANDOM = keccak256("THIS IS RANDOM");
        wordlings.mintMysteryBox{value: 0.5 ether}();
    }

}
