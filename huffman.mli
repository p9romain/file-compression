val decompress : string -> unit
(** [decompresss s] takes a [s = "name.ext.hf"] file and decompresses it into a "new_name.ext" file*)

val compress : string -> unit
(** [compresss s] take a [s = "name.ext"] file and compresses it into a "name.ext.hf" file using Huffman algorithm*)