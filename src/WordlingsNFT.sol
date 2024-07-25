// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@pythnetwork/entropy-sdk-solidity/IEntropy.sol";
import "@pythnetwork/entropy-sdk-solidity/IEntropyConsumer.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";
import {Test, console} from "forge-std/Test.sol";


contract WordlingsNFT is ERC1155, Ownable, ERC1155Pausable, ERC1155Burnable, IEntropyConsumer{
    
    // GAME-RULES
    
    // After minting of 20 NFTs, account holder has a cooldown of 15 minutes only after which he can mint more NFTs
    // Random NFT Minting is possible for unlimited amount
    // NFTs can be minted only when the game session has started

    // gameStarted is a boolean variable to keep track of the game session
    bool public gameStarted;

    // mapping of owners keeping track of nfts they minted
    mapping(address => uint256) public nftMinted;

    // mapping of owners keeping track of the unique nft they minted
    mapping(address => uint256[]) public uniqueNftMinted;

    // mapping of owners keeping track of the time they minted their last nft
    mapping(address => uint256) public lastMintedTime;

    // mapping of owners based on sequence numbers
    mapping(uint64 => address) public requestedUsers;

    uint256 public totalMinted = 0;

    using EnumerableMap for EnumerableMap.UintToAddressMap;

    // Cooldown Time
    uint256 public COOLDOWN_TIME;

    // Mint Fee for NFT
    uint256 public MINT_FEE; // 0.00000005 ETH

    // Pyth Entropy
    IEntropy public entropy;
    address public entropyProvider;

    // Event emitted when Wordlings Mystery Box is request
    event MysteryBoxRequest(uint64 sequenceNumber);

    // Event emitted when the Wordlings Mystery Box is Minted
    event NFTMinted(address user, uint256 nftid);


    modifier onlyWhenGameStarted() {
        require(gameStarted, "Game session has not started yet");
        _;
    }

    constructor(address initialOwner, address _entropy, address _provider) Ownable(initialOwner) ERC1155(""){
        entropy = IEntropy(_entropy);
        entropyProvider = _provider;
        COOLDOWN_TIME = 15 minutes;
        MINT_FEE = 5 ether / 100_000_000;
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

    function startGame() public onlyOwner {
        gameStarted = true;
    }

    function endGame() public onlyOwner {
        gameStarted = false;
    }

    // function that puts a cooldowntime of 15 minutes after 20 NFTs have minted
    // If totalMinted amount is divisible by 20, then it will mean that the countdown kicks in
    // function mintMysteryBox() public payable onlyWhenGameStarted {
    //     if (nftMinted[msg.sender] != 0 && nftMinted[msg.sender] % 20 == 0 ){
    //         require(block.timestamp - lastMintedTime[msg.sender] > 15 minutes, "You have to wait for 15 minutes to mint more NFTs"); 
    //     }
    //     require(msg.value >= MINT_FEE, "Insufficient funds to mint NFT");
    //     uint256 alphabet = random();
    //     nftMinted[msg.sender] += 1;
    //     lastMintedTime[msg.sender] = block.timestamp;
    //     _mint(msg.sender, alphabet, 1, "");
    //     _refund();
    // }

    // function to refund the extra amount sent by the user
    function _refund() internal {
        if (msg.value > MINT_FEE + getMysteryBoxFee()) {
            payable(msg.sender).transfer(msg.value - MINT_FEE - getMysteryBoxFee());
        }
    }

    receive() external payable {
    }

    // function that creates random number from 1 to 71
    function random() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.number))) % 71 + 1;
    }

    // function to remove all ether from the smart contract
    function withdraw(address receiver) public onlyOwner {
        require(receiver!=address(0), "Invalid Address");
        payable(receiver).transfer(address(this).balance);
    }

    // This method is required by the IEntropyConsumer interface
    function getEntropy() internal view override returns (address) {
         return address(entropy);
    }

    // Entropy from Pyth
    function requestMysteryBox(bytes32 userRandomNumber) external payable {
        if ( nftMinted[msg.sender] != 0 && nftMinted[msg.sender] % 20 == 0 ){
            require(block.timestamp - lastMintedTime[msg.sender] > 15 minutes, "You have to wait for 15 minutes to mint more NFTs"); 
        }
       
        // get the required fee
        uint128 requestFee = entropy.getFee(entropyProvider);
        
        // check if the user has sent enough fees
        // if (msg.value < requestFee) revert("not enough fees");
        require(msg.value >= MINT_FEE + requestFee, "Insufficient funds to mint NFT");
 
        // pay the fees and request a random number from entropy
        uint64 sequenceNumber = entropy.requestWithCallback{ value: requestFee }(
            entropyProvider,
            userRandomNumber
        );

        requestedUsers[sequenceNumber] = msg.sender;

        // _refund();
 
        // emit event
        emit MysteryBoxRequest(sequenceNumber);
    }

    // Get the fee to flip a coin. See the comment above about fees.
    function getMysteryBoxFee() public view returns (uint256 fee) {
        fee = entropy.getFee(entropyProvider);
    }

     function entropyCallback(
        uint64 sequenceNumber,
        // If your app uses multiple providers, you can use this argument
        // to distinguish which one is calling the app back. This app only
        // uses one provider so this argument is not used.
        address ,
        bytes32 randomNumber
        ) internal override {
       
        uint256 id = uint256(randomNumber) % 71 + 1; // means lowest value can be either 0 + 1 and max value can be 70 + 1 = 71 
       
        address user = requestedUsers[sequenceNumber];
        totalMinted += 1;

        if (balanceOf(user, id) == 0 ){
            uniqueNftMinted[user].push(id);
        }

        nftMinted[user] += 1;
        lastMintedTime[user] = block.timestamp;
        _mint(user, id, 1, "");

        emit NFTMinted(user, id);
    }

    // function to get the unique nfts minted by the user
    function getUniqueNftMinted(address user) public view returns (uint256[] memory) {
        return uniqueNftMinted[user];
    }
}






























