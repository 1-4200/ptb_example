import {executeTxb, moduleName, numbers, packageId, recipients} from "./index.ts";
import {TransactionBlock} from "@mysten/sui.js/transactions"

function mintAndSend(txb: TransactionBlock, recipients: string[], numbers: number[]) {
    numbers.forEach((number, i) => {
        const mintedNft = txb.moveCall({
            target: `${packageId}::${moduleName}::mint_and_send`,
            arguments: [
                txb.pure(number),
                txb.pure(recipients[i]),
            ],
        });
    });
}

async function run(recipients: string[], numbers: number[]) {
    const txb = new TransactionBlock();
    mintAndSend(txb, recipients, numbers);
    await executeTxb(txb);
}

run(recipients, numbers);
