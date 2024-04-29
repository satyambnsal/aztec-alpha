mod interfaces;

contract PrivateVoting {
    use dep::aztec::prelude::{AztecAddress, Map, PublicMutable, FunctionSelector, SharedImmutable};
    use dep::aztec::context::Context;
    use voting_contract::interfaces::SlowMap;

    #[aztec(storage)]
    struct Storage {
      admin: PublicMutable<AztecAddress>,
      votes: Map<Field, PublicMutable<Field>>,
      voteEnded: PublicMutable<bool>,
      slow_update: SharedImmutable<AztecAddress>,
  }

    #[aztec(initializer)]
    #[aztec(public)]
    fn constructor(admin: AztecAddress, slow_updates_contract: AztecAddress) {
        storage.admin.write(admin);
        storage.voteEnded.write(false);
        storage.slow_update.initialize(slow_updates_contract);
        SlowMap::at(slow_updates_contract).initialize(&mut context);
    }

    #[aztec(public)]
    fn add_to_votes_public(candidate: Field) {
        let new_vote = storage.votes.at(candidate).read() + 1;
        storage.votes.at(candidate).write(new_vote);
    }

    #[aztec(private)]
    fn cast_vote(candidate: Field) {
        let secret = context.request_nullifier_secret_key(context.msg_sender());
        let nullifier = dep::std::hash::pedersen_hash([context.msg_sender().to_field(), secret.low, secret.high]);
        context.push_new_nullifier(nullifier, 0);
        let res = context.call_public_function(
            context.this_address(),
            FunctionSelector::from_signature("is_end_vote"),
            []
        );
        assert(res.eq(false), "voting already ended");

        let secret = context.request_nullifier_secret_key(context.msg_sender());
        let nullifier = dep::std::hash::pedersen_hash([context.msg_sender().to_field(), secret.low, secret.high]);
        context.push_new_nullifier(nullifier, 0);

        context.call_public_function(
            context.this_address(),
            FunctionSelector::from_signature("add_to_votes_public(Field)"),
            [candidate]
        );
    }

    #[aztec(public)]
    fn is_end_vote() {
        storage.voteEnded.read()
    }

    #[aztec(public)]
    fn end_vote() {
        assert(storage.admin.read().eq(context.msg_sender()), "only admins can end vote");
        storage.voteEnded.write(true);
        let slow = SlowMap::at(storage.slow_update.read_public());
        
    }

    unconstrained fn view_vote(candidate: Field) -> pub Field {
        storage.votes.at(candidate).read()
    }
}
