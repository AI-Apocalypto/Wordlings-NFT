## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Blast Testnet Forking 
```shell
forge test --fork-url $BLAST_SEPOLIA_RPC_URL --fork-block-number 6896546 -vvvv
```

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

## WordlingsNFT.sol on Blast Sepolia 
```shell
##### blast-sepolia
✅  [Success]Hash: 0x62c2c8af94ad681629a476f50a957fcad5005fd67f46aabc3b369d390d4b71b9
Contract Address: 0x4CAD1905BD03fb2268F75e8f780D7f11196a9994
Block: 6896545
Paid: 0.007549434634152456 ETH (2516478 gas * 3.000000252 gwei)


##### blast-sepolia
✅  [Success]Hash: 0x4aaf672141055806dac0e9d5e92ce3c7b7a43e50e6820a7517126df7f5d0bd84
Contract Address: 0xa6bF27b198f059880b6427E56f88e5f2f67Dbb48
Block: 6896545
Paid: 0.000828981069634404 ETH (276327 gas * 3.000000252 gwei)



==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.00837841570378686 ETH (2792805 gas * avg 3.000000252 gwei)

Transactions saved to: /Users/shanzson/Code/aiapocalypto/broadcast/WordlingsNFT.s.sol/168587773/run-latest.json

Sensitive values saved to: /Users/shanzson/Code/aiapocalypto/cache/WordlingsNFT.s.sol/168587773/run-latest.json
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
