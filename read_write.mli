open Hash_table
open Tree

val occ_hash : string -> hash
(**docu à faire*)

val file_to_huff_string : hash -> string -> string 
(**docu à faire*)

val write : string -> string -> unit
(**docu à faire*)

val header_to_tree : in_channel -> tree
(**docu à faire*)

val transcript_body : tree -> in_channel -> out_channel -> unit
(**docu à faire*)