# scripts

To install dependencies:

```bash
bun install
```

## PTB

> On Sui, a transaction is more than a basic record of the flow of assets. Transactions on Sui are composed of a number
> of
> commands that execute on inputs to define the result of the transaction. Termed programmable transaction blocks (
> PTBs),
> these groups of commands define all user transactions on Sui. PTBs allow a user to call multiple Move functions,
> manage
> their objects, and manage their coins in a single transaction--without publishing a new Move package.

https://docs.sui.io/concepts/transactions/prog-txn-blocks

## Getting Started

To run:

```bash
cp .env.example .env
```

### mint_and_send

Add `mint_and_send` function call to the Move call of the PTB for XXX times and execute it

```bash
bun run mint_and_send.ts
```

Sample tx result:
https://suiexplorer.com/txblock/6UhcSvToyZ7rJmsz37RoR9DWS2fCsT4ZBCyTw2Cg6ocd?network=testnet

### batch_mint_and_send

```bash
bun run batch_mint_and_send.ts
```

Sample tx result:
https://suiexplorer.com/txblock/F7pKaCMKnwLxem2M15dPhEuc5hmTLd1tyXCb5fw4oUaw?network=testnet
