type elem_tree = int
(** docu à faire *)

type tree =
| L of elem_tree
| N of tree * tree
(** docu à faire *)

val val_leaf : tree -> elem_tree
(** docu à faire *)

val left_tree : tree -> tree
(** docu à faire *)

val right_tree : tree -> tree
(** docu à faire *)

val print_leaf : elem_tree -> unit
(** docu à faire *)

val merge_tree : tree -> tree -> tree
(** docu à faire *)

val print : tree -> unit
(** docu à faire *)

val prefixe_bin : tree -> string
(** docu à faire *)

val huff_tab : tree -> (int * string) list
(** docu à faire *)

val huff_tree : Hash_table.elem_hash list -> tree
(** docu à faire *)