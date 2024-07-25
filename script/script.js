const { Web3 } = require("web3");
const WordlingsAbi = require("../out/WordlingsNFT.sol/WordlingsNFT.json");
const EntropyAbi = require("@pythnetwork/entropy-sdk-solidity/abis/IEntropy.json");
 
async function main() {
  const web3 = new Web3(process.env["BLAST_SEPOLIA_RPC_URL"]);
  const { address } = web3.eth.accounts.wallet.add(
    process.env["PRIVATE_KEY"]
  )[0];
 
  web3.eth.defaultBlock = "finalized";
 
  const wordlingsContract = new web3.eth.Contract(
    WordlingsAbi.abi,
    process.env["WORDLINGS_ADDRESS"]
  );
 
  const entropyContract = new web3.eth.Contract(
    EntropyAbi,
    process.env["ENTROPY_ADDRESS"]
  );
  
  // Request a random number
 
  // Generate user random number
  const userRandomNumber = web3.utils.randomHex(32);
 
  const fee = await entropyContract.methods.getFee(process.env["PROVIDER_ADDRESS"]).call()
  console.log(`fee         : ${fee}`);

  // ---------------------------- START GAME ------------------------------
//   const startGameReceipt = await wordlingsContract.methods.startGame().send({
//     from: address,
//     });
    wordlingsContract.methods.gameStarted().call().then(console.log);
    // // console.log(`gameStarted: `)
    // wordlingsContract.methods.nftMinted(address).call().then(console.log);



  const requestReceipt = await wordlingsContract.methods
    .requestMysteryBox(userRandomNumber)
    .send({
      value: fee + 500000000000000n,
      from: address,
    });
 
  console.log(`request tx  : ${requestReceipt.transactionHash}`);
  // Read the sequence number for the request from the transaction events.
  const sequenceNumber =
  requestReceipt.events.MysteryBoxRequest.returnValues.sequenceNumber;
  console.log(`sequence    : ${sequenceNumber}`);

  let fromBlock = requestReceipt.blockNumber;
  const intervalId = setInterval(async () => {
    const currentBlock = await web3.eth.getBlockNumber();
 
    if(fromBlock > currentBlock) {
      return;
    }
 
    // Get 'FlipResult' events emitted by the CoinFlip contract for given block range.
    const events = await wordlingsContract.getPastEvents("MysteryBoxResult", {
      fromBlock: fromBlock,
      toBlock: currentBlock,
    });
    fromBlock = currentBlock + 1n;
 
    // Find the event with the same sequence number as the request.
    const event = events.find(event => event.returnValues.sequenceNumber === sequenceNumber);
 
    // If the event is found, log the result and stop polling.
    if(event !== undefined) {
      console.log(`result      : ${event.returnValues.id}`);
      clearInterval(intervalId);
    }
 
  }, 1000);
}
 
main();