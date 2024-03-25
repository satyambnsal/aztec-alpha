mod interfaces;
mod util;

// Demonstrates how to use portal contracts to swap on L1 Uniswap with funds on L2
// Has two separate flows for private and public respectively
// Uses the token bridge contract, which tells which input token we need to talk to and handles the exit funds to L1
contract Uniswap {
    use dep::aztec::prelude::{FunctionSelector, AztecAddress, EthAddress, Map, PublicMutable};
    use dep::aztec::oracle::context::get_portal_address;

    use dep::authwit::auth::{
        IS_VALID_SELECTOR, assert_current_call_valid_authwit_public, compute_call_authwit_hash,
        compute_outer_authwit_hash
    };

    use crate::interfaces::{Token, TokenBridge};
    use crate::util::{compute_swap_private_content_hash, compute_swap_public_content_hash};

    struct Storage {
        // like with account contracts, stores the approval message on a slot and tracks if they are active
        approved_action: Map<Field, PublicMutable<bool>>,
        // tracks the nonce used to create the approval message for burning funds
        // gets incremented each time after use to prevent replay attacks
        nonce_for_burn_approval: PublicMutable<Field>,
    }

    // Since the token bridge burns funds on behalf of this contract, this contract has to tell the token contract if the signature is valid
    // implementation is similar to how account contracts validate public approvals.
    // if valid, it returns the IS_VALID selector which is expected by token contract
    #[aztec(public)]
    fn spend_public_authwit() {}

    // This helper method approves the bridge to burn this contract's funds and exits the input asset to L1
    // Assumes contract already has funds.
    // Assume `token` relates to `token_bridge` (ie token_bridge.token == token)
    // Note that private can't read public return values so created an internal public that handles everything
    // this method is used for both private and public swaps.
    #[aztec(public)]
    #[aztec(internal)]
    fn _approve_bridge_and_exit_input_asset_to_L1() {}

    #[aztec(private)]
    fn swap_private() {}

     #[aztec(public)]
    fn swap_public() {
        if (!sender.eq(context.msg_sender())) {
            assert_current_call_valid_authwit_public(&mut context, sender);
        }

        let input_asset = TokenBridge::at(input_asset_bridge).token(&mut context);

        // Transfer funds to this contract
        Token::at(input_asset).transfer_public(
            &mut context,
            sender,
            context.this_address(),
            input_amount,
            nonce_for_transfer_approval
        );

        // Approve bridge to burn this contract's funds and exit to L1 Uniswap Portal
        let _void = context.call_public_function(
            context.this_address(),
            FunctionSelector::from_signature("_approve_bridge_and_exit_input_asset_to_L1((Field),(Field),Field)"),
            [input_asset.to_field(), input_asset_bridge.to_field(), input_amount]
        );

        // Create swap message and send to Outbox for Uniswap Portal
        // this ensures the integrity of what the user originally intends to do on L1.
        let input_asset_bridge_portal_address = get_portal_address(input_asset_bridge);
        let output_asset_bridge_portal_address = get_portal_address(output_asset_bridge);
        // ensure portal exists - else funds might be lost
        assert(
            !input_asset_bridge_portal_address.is_zero(), "L1 portal address of input_asset's bridge is 0"
        );
        assert(
            !output_asset_bridge_portal_address.is_zero(), "L1 portal address of output_asset's bridge is 0"
        );

        let content_hash = compute_swap_public_content_hash(
            input_asset_bridge_portal_address,
            input_amount,
            uniswap_fee_tier,
            output_asset_bridge_portal_address,
            minimum_output_amount,
            recipient,
            secret_hash_for_L1_to_l2_message,
            caller_on_L1
        );
        context.message_portal(context.this_portal_address(), content_hash);
    }


    #[aztec(public)]
    #[aztec(internal)]
    fn _assert_token_is_same(token: AztecAddress, token_bridge: AztecAddress) {
        assert(
            token.eq(TokenBridge::at(token_bridge).token(&mut context)), "input_asset address is not the same as seen in the bridge contract"
        );
    }
}