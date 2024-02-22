module ptb_example::mint {
    use std::string::utf8;
    use std::vector;
    
    use sui::display;
    use sui::object;
    use sui::object::UID;
    use sui::package;
    use sui::transfer;
    use sui::tx_context::{sender, TxContext};
    
    const ELengthDoesNotMatch: u64 = 0;
    
    struct MINT has drop {}
    
    struct NFT has key, store {
        id: UID,
        number: u64,
    }
    
    fun init(otw: MINT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"number"),
            utf8(b"image_url"),
        ];
        
        let values = vector[
            utf8(b"{number}"),
            utf8(b"https://picsum.photos/id/{number}/1000/1000"),
        ];
        let publisher = package::claim(otw, ctx);
        let display = display::new_with_fields<NFT>(
            &publisher, keys, values, ctx
        );
        display::update_version(&mut display);
        
        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));
    }
    
    
    // First approach: simply mint and send in one step
    // mint_and_send is a public function that creates a new NFT and sends it to the specified address
    public fun mint_and_send(number: u64, to: address, ctx: &mut TxContext) {
        transfer::public_transfer(NFT { id: object::new(ctx), number }, to);
    }
    
    // Second approach: batch mint and send in one step
    // batch_mint_and_send is a public function that creates new NFTs and sends them to the specified addresses
    public fun batch_mint_and_send(
        recipients: vector<address>,
        numbers: vector<u64>,
        ctx: &mut TxContext
    ) {
        let (i, recipients_len, numbers_len) = (0, vector::length(&recipients), vector::length(&numbers));
        assert!(recipients_len == numbers_len, ELengthDoesNotMatch);
        
        while (i < recipients_len) {
            let recipient = vector::pop_back(&mut recipients);
            let number = vector::pop_back(&mut numbers);
            mint_and_send(number, recipient, ctx);
            i = i + 1;
        }
    }
}
