contract PrivateVoting {
    use dep::aztec::prelude::{AztecAddress, Map, PublicMutable, FunctionSelector};
    use dep::aztec::context::Context;

    #[aztec(storage)]
    struct Storage {
      admin: PublicMutable<AztecAddress>,
      votes: Map<Field, PublicMutable<Field>>,
      voteEnded: PublicMutable<bool>
  }

    #[aztec(initializer)]
    #[aztec(public)]
    fn constructor(admin: AztecAddress) {
        storage.admin.write(admin);
        storage.voteEnded.write(false);
    }

    #[aztec(public)]
    fn add_to_votes_public(candidate: Field) {
        let new_vote = storage.votes.at(candidate).read() + 1;
        storage.votes.at(candidate).write(new_vote);
    }

    #[aztec(private)]
    fn cast_vote(candidate: Field) {
        assert(storage.voteEnded.read().eq(false), "voting already ended");

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
    fn end_vote() {
        assert(storage.admin.read().eq(context.msg_sender()), "only admins can end vote");
        storage.voteEnded.write(true);
    }

    unconstrained fn view_vote(candidate: Field) -> pub Field {
        storage.votes.at(candidate).read()
    }
}
