// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {WordlingsNFT} from "../src/WordlingsNFT.sol";

import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract WordlingsTest is Test {
    WordlingsNFT public wordlings;
    address _owner = 0x9131659d334558138548b128E3Ac7557212B5Efe;

    address _entropy = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;

    address _provider = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;

    address public bob = address(0x23);
    address public alice = address(0x55);

    function setUp() public {
        wordlings = new WordlingsNFT(_owner, _entropy, _provider);
    }

    function test_GameState() public {
        bool stat = wordlings.gameStarted();
        console.log("%s", stat);
    }
    
    function test_mintMysteryBox() public {
        vm.prank(_owner);
        wordlings.startGame();
        bool stat = wordlings.gameStarted();
        console.log("Game started: %s", stat);
        deal(bob, 10 ether);
        console.log("Bob's balance: %s", bob.balance);
        
        vm.startPrank(bob);
        bytes32 RANDOM = keccak256("THIS IS RANDOM");
        wordlings.requestMysteryBox{value: 0.005 ether}(RANDOM);
        // wordlings.requestMysteryBox{value: 0.5 ether}();
        // wordlings.requestMysteryBox{value: 0.5 ether}();
        // wordlings.requestMysteryBox{value: 0.5 ether}();


        vm.stopPrank();

        console.log("NFTs minted by Bob: %s", wordlings.nftMinted(bob));
        // uint256[] memory userArray = ;
        //    wordlings.uniqueNftMinted(bob,0);
        //    uint256 userArray = wordlings.uniqueNftMinted(bob,1);
        // for (uint256 i = 0; i < l; i++) {
        //     console.log("%s", wordlings.uniqueNftMinted[i]);
        // }
        uint256 len = wordlings.getUniqueNftMinted(bob).length;
        console.log("Unique NFTs Minted by Bob: %s", len);
        console.log("Total NFTs minted: %s", wordlings.totalMinted());
        // for (uint256 i = 0; i < len; i++) {
        //     console.log("%s", wordlings.uniqueNftMinted(bob)[i]);
        // }
        // // console.log("%s", bob);
    }

}
