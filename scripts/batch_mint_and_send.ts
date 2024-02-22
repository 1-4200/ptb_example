import {executeTxb, moduleName, numbers, packageId, recipients} from "./index.ts";
import {TransactionBlock} from "@mysten/sui.js/transactions"

function _batchMintAndSend(txb: TransactionBlock, recipients: string[], numbers: number[]) {
    txb.moveCall({
        target: `${packageId}::${moduleName}::batch_mint_and_send`,
        arguments: [
            txb.pure(recipients),
            txb.pure(numbers),
        ],
    });
}

function batchMintAndSend(txb: TransactionBlock, recipients: string[], numbers: number[]) {
    // The limit of the size that can be entered in one PTB command is 16KB,
    // and Sui's address is 32bytes, so divide the size into 500 addresses (15.6KB) each
    // and enter as a Move call in PTB
    const batchSize = 500;
    for (let i = 0; i < recipients.length; i += batchSize) {
        const recipientsBatch = recipients.slice(i, i + batchSize);
        const numbersBatch = numbers.slice(i, i + batchSize);
        _batchMintAndSend(txb, recipientsBatch, numbersBatch);
    }
}

async function run(recipients: string[], numbers: number[]) {
    const txb = new TransactionBlock();
    batchMintAndSend(txb, recipients, numbers);
    await executeTxb(txb);
}

run(recipients, numbers);
