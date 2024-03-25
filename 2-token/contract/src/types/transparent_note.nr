// docs:start:token_types_all
use dep::aztec::prelude::{NoteHeader, NoteInterface, PrivateContext};
use dep::aztec::{note::{utils::compute_note_hash_for_consumption}, hash::{compute_secret_hash, pedersen_hash}};


// impl NoteInterface<TRANSPARENT_NOTE_LEN> for TransparentNote {
//     fn serialize_content(self) -> [Field; TRANSPARENT_NOTE_LEN] {
//         [self.amount, self.secret_hash]
//     }

//     fn deserialize_content(serialized_note: [Field; TRANSPARENT_NOTE_LEN]) -> Self {
//         TransparentNote {
//             amount: serialized_note[0],
//             secret_hash: serialized_note[1],
//             secret: 0,
//             header: NoteHeader::empty(),
//         }
//     }

//     fn compute_note_content_hash(self) -> Field {
//         pedersen_hash(self.serialize_content(), 0)
//     }

//     fn compute_nullifier(self, _context: &mut PrivateContext) -> Field {
//         self.compute_nullifier_without_context()
//     }

//     fn compute_nullifier_without_context(self) -> Field {
//         let siloed_note_hash = compute_note_hash_for_consumption(self);
//         // TODO(#1205) Should use a non-zero generator index.
//         pedersen_hash([self.secret, siloed_note_hash],0)
//     }

//     fn set_header(&mut self, header: NoteHeader) {
//         self.header = header;
//     }

//     fn get_header(self) -> NoteHeader {
//         self.header
//     }

//     fn broadcast(self, context: &mut PrivateContext, slot: Field) {
//         assert(false, "TransparentNote does not support broadcast");
//     }

//     fn get_note_type_id() -> Field {
//         84114971101151129711410111011678111116101
//     }
// }
