val occ_hash : string -> Hash_table.hash
(**docu à faire*)

val file_to_huff_string : Hash_table.hash -> string -> string 
(**docu à faire*)

val write : string -> string -> unit
(**docu à faire*)

val header_to_tree : Bs.istream -> Tree.tree
(**docu à faire*)

val transcript_body : Tree.tree -> Bs.istream -> out_channel -> unit
(**docu à faire*)
