val occ_hash : string -> Hash_table.hash
(** [occ_hash s] opens the file [s] and count the number of each characters in the file, creating a hash_table to stock them *)

val file_to_huff_string : Hash_table.hash -> string -> string 
(** [file_to_huff_string hash s] open the file [s] and create a string with all the text replaced by the Huffman code of each characters *)

val write : string -> string -> unit
(** [write file_name s] write a string [s] in the file [file_name] *)

val header_to_tree : Bs.istream -> Tree.tree
(** [header_to_tree stream] creates the Huffman tree stocked at the start of the file [stream] *)

val transcript_body : Tree.tree -> Bs.istream -> out_channel -> unit
(** [transcript_body tree stream_in channel_out] read the file [stream_in] and for each 0 and 1, translate it into a characters using [tree] and writes it in the file [channel_out] *)
