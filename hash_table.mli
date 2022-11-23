type elem_hash = (int * int)
(**docu à faire*)

type hash = (elem_hash array * (int -> int) * (int -> int))
(**docu à faire*)

val construct : int -> elem_hash -> hash
(**docu à faire*)

val hash_map_1 : int -> int -> int
(**docu à faire*)

val hash_map_2 : int -> int -> int
(**docu à faire*)

val find : hash -> int -> int * bool
(**docu à faire*)

val incr : elem_hash array -> int -> unit
(**docu à faire*)

val list_of_array : elem_hash array -> elem_hash list
(**docu à faire*)

val print : elem_hash array -> unit
(**docu à faire*)