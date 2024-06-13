// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MyToken is Initializable, ERC1155Upgradeable, OwnableUpgradeable, ERC1155PausableUpgradeable, ERC1155BurnableUpgradeable, UUPSUpgradeable {
    
    // GAME-RULES
    
    // After minting of 20 NFTs, account holder has a cooldown of 15 minutes only after which he can mint more NFTs
    // Random NFT Minting is possible for unlimited amount
    // NFTs can be minted only when the game session has started

    // gameStarted is a boolean variable to keep track of the game session
    bool gameStarted;

    // mapping of owners keeping track of nfts they minted
    mapping(address => uint256) public nftMinted;

    // mapping of owners keeping track of the time they minted their last nft
    mapping(address => uint256) public lastMintedTime;

    // Cooldown Time
    uint256 COOLDOWN_TIME = 15 minutes;

    // Mint Fee for NFT
    uint256 MINT_FEE = 5 ether / 100_000; // 0.00005 ETH

    modifier onlyWhenGameStarted() {
        require(gameStarted, "Game session has not started yet");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __ERC1155_init("");
        __Ownable_init(initialOwner);
        __ERC1155Pausable_init();
        __ERC1155Burnable_init();
        __UUPSUpgradeable_init();
    }


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // function mint(address account, uint256 id, uint256 amount, bytes memory data)
    //     public
    //     onlyWhenGameStarted
    // {
    //     _mint(account, id, amount, data);
    // }

    // function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
    //     public
    //     onlyOwner
    // {
    //     _mintBatch(to, ids, amounts, data);
    // }

    // The following functions are overrides required by Solidity.
    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable)
    {
        super._update(from, to, ids, values);
    }


    // function that puts a cooldowntime of 15 minutes after 20 NFTs have minted
    // If totalMinted amount is divisible by 20, then it will mean that the countdown kicks in
    function wordlingsNFT() public onlyWhenGameStarted {
        // require(nftMinted[msg.sender] % 20 != 0, "You have to wait for 15 minutes to mint more NFTs");
        if ( nftMinted[msg.sender] % 20 == 0 ){
            require(block.timestamp - lastMintedTime[msg.sender] > 15 minutes, "You have to wait for 15 minutes to mint more NFTs"); 
        }
        require(msg.value >= MINT_FEE, "Insufficient funds to mint NFT");
        uint256 alphabet = random();
        nftMinted[msg.sender] += 1;
        lastMintedTime[msg.sender] = block.timestamp;
        _mint(msg.sender, alphabet, 1, "");
        _refund();
    }

    // function to refund the extra amount sent by the user
    function _refund() internal {
        if (msg.value > MINT_FEE) {
            payable(msg.sender).transfer(msg.value - MINT_FEE);
        }
    }

    receive() external payable {
    }

    // function that creates random number from 1 to 71
    function random() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.number))) % 71 + 1;
    }



















    
}






























