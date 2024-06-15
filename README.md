## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.


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
