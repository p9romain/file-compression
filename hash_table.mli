type elem_hash = 
| Occ of (int * int)
| Code of (int * string)
(** The type of an element in our hash table. The type is made in order to usef the same array before and after making the huffman code for a character. (utf8-code, occurence) and (utf8-code, huffman code) *)

type hash = elem_hash array * (int -> int) * (int -> int)
(** The type of our hash table. It has an array of elem_has, and two hash functions to find an element in the array *)

val hash_map_1 : int -> int -> int
(** [hash_map_1 n i] returns the index in the array of the utf8-code [i], where [n] is the length of the array *)

val hash_map_2 : int -> int -> int
(** [hash_map_2 n i] returns the 2nd value used to find and element in an hash table, where [n] is the length of the array and [i] the utf8-code of an element *)

val construct : int -> elem_hash -> hash
(** [construct n x0] return an hash where [n] is the length of the array and [x0] the default value in the array *)

val find : hash -> int -> int * bool
(** [find (a, h1, h2) x] returns the pair of the index of the element [x] in the array [a] and [true] if [a] contains [x]. The boolean is useful to know if we need to add [x] or not. *)

val list_of_array : elem_hash array -> elem_hash list
(** [list_of_array a] returns a list of all the elements of [a], except the "holes" *)

val print_elem_hash : elem_hash -> unit
(** [print_elem_hash e] prints [e] *)

val print : elem_hash array -> unit
(** [print a] prints [a]*)

val char_elem_hash : elem_hash -> int
(** [char_elem_hash e] returns the utf8-code of [e] *)

val occ_elem_hash : elem_hash -> int
(** [occ_elem_hash e] returns the occurence of [e]. May throw an exception if [e] isn't a elem_hash.Occ *)

val code_elem_hash : elem_hash -> string
(** [code_elem_hash e] returns the huffman code of [e]. May throw an exception if [e] isn't a elem_hash.Code *)