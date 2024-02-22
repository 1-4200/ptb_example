# ptb_example

## Prerequisites

- [Sui CLI](https://docs.sui.io/guides/developer/getting-started/sui-install) - Sui is a command line tool that helps
  you to create, build, and deploy your Sui applications
- [Bun](https://bun.sh/docs/installation#installing) -Bun is an all-in-one toolkit for JavaScript and TypeScript apps.
  It ships as a single executable called `bun`

## Getting Started

### Smart Contract

Change to the `move` directory to work with the smart contract.

#### Building

```zsh
sui move build
```

#### Testing

```zsh
sui move test
```

#### Deploying

Make sure your sui client is looking at the right network and has enough gas to publish the contract.

```zsh
sui client publish ./ --gas-budget 100000000
```
