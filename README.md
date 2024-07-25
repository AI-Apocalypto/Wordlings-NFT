## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Deploying on Blast Testnet
```shell
 forge script --chain 168587773 script/WordlingsNFT.s.sol:MyScript --rpc-url $BLAST_SEPOLIA_RPC_URL --broadcast --verify -vvvv
```

## Blast Testnet Forking 
```shell
forge test --fork-url $BLAST_SEPOLIA_RPC_URL --fork-block-number 6896546 -vvvv
```

Note: It is highly unlikely that Pyth Entropy will work on Forked network as traditional provider will not be able to fulfill the calls.

## Pyth CoinFlip Addresses
```shell
// ARBITRUM SEPOLIA ADRESSES

Deployer: 0x9131659d334558138548b128E3Ac7557212B5Efe
Deployed to: 0x4CAD1905BD03fb2268F75e8f780D7f11196a9994
Transaction hash: 0xd16acbb1649ad54f00ca50f0956151346ae0aa2e587bd32ea1658692f48b3254
```
## Dummy NFT.sol Deployment on Arbitrum Sepolia
```shell
✅  [Success]Hash: 0x96cb7ec063201cbe57c33c8162a98d986df95d0f77e2d9697955683c51a491dc
Contract Address: 0x70f4804233aE1A55e9DaC81F2e5FB93fdaC32BC1
Block: 54861077
Paid: 0.0001294756 ETH (1294756 gas * 0.1 gwei)
```

## Tx of 1st NFT Minted
```shell
https://blastscan.io/tx/0x5f75d447026ab4abf068aa0b40bb56be1b1f18fde20398085c6c2abb3bab4714
```

## WordlingsNFT.sol on Blast Mainnet
```shell

##### blast
✅  [Success]Hash: 0x9ec454cb7ed8202632549b22c8d5611bb07a454c47c13333aeb5e08b24c350df
Contract Address: 0x4CAD1905BD03fb2268F75e8f780D7f11196a9994
Block: 6542111
Paid: 0.006344294039729898 ETH (2114403 gas * 3.000513166 gwei)

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.006344294039729898 ETH (2114403 gas * avg 3.000513166 gwei)
##
Start verification for (1) contracts
Start verifying contract `0x4CAD1905BD03fb2268F75e8f780D7f11196a9994` deployed on blast

Submitting verification for [src/WordlingsNFT.sol:WordlingsNFT] 0x4CAD1905BD03fb2268F75e8f780D7f11196a9994.
Submitted contract for verification:
        Response: `OK`
        GUID: `6ibajpzssjtwatkc3juee9v81xzs6dnxyypvec9macmjrrajkc`
        URL: https://blastscan.io/address/0x4cad1905bd03fb2268f75e8f780d7f11196a9994
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
All (1) contracts were verified!

Transactions saved to: /Users/shanzson/Code/aiapocalypto/broadcast/WordlingsNFT.s.sol/81457/run-latest.json

Sensitive values saved to: /Users/shanzson/Code/aiapocalypto/cache/WordlingsNFT.s.sol/81457/run-latest.json
```

## WordlingsNFT.sol Deployment on Arbitrum Sepolia

```shell

##### arbitrum-sepolia
✅  [Success]Hash: 0x260ef1008f916d3bbf095badf4ad25729db9795c41cbbed7df4443598bf95b66
Contract Address: 0x0609199f438c54F833131e22229ceA3C7bCF8060
Block: 55004520
Paid: 0.0002516478 ETH (2516478 gas * 0.1 gwei)

##
Sending transactions [1 - 1].
⠉ [00:00:09] [###########################################################################################################################################################] 2/2 txes (0.0s)##
Waiting for receipts.
⠉ [00:00:06] [#######################################################################################################################################################] 1/1 receipts (0.0s)
##### arbitrum-sepolia
✅  [Success]Hash: 0xe2763dd650c29a730dedcc82b270ed1f3d993745c88333e932fdd00bf0efdda7
Contract Address: 0x1E4119E191C0207459A428Cb6ED76B9dd954e691
Block: 55004551
Paid: 0.0000276327 ETH (276327 gas * 0.1 gwei)



==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
```

## Pyth How to generate Random numbers
https://docs.pyth.network/entropy/generate-random-numbers

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
