type elem = int
type tree 
(** docu à faire *)

val val_leaf : tree -> elem
(** docu à faire *)

val print_leaf : elem -> unit
(** docu à faire *)

val print_tree : tree -> unit
(** docu à faire *)

val left_tree : elem tree -> elem tree
(** docu à faire *)

val right_tree : elem tree -> elem tree
(** docu à faire *)

val merge_tree : tree -> tree -> tree
(** docu à faire *)

(* val huff_tab : elem tree -> (string * int) list *)
(** docu à faire *)

val huff_tree : (int * int) list -> tree
(** docu à faire *)