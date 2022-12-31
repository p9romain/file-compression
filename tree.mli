type elem_tree = int
(** The type of an element in the tree. It's the utf8-code of the char, so an integer. *)

type tree =
| L of elem_tree
| N of tree * tree
(** The type of a tree. It's either an leaf or an node (two trees) *)

(** UNUSED

val val_leaf : tree -> elem_tree
(** docu à faire *)

val left_tree : tree -> tree
(** docu à faire *)

val right_tree : tree -> tree
(** docu à faire *) *)

val print_leaf : elem_tree -> unit
(** [print_leaf l] prints the char with [l] as utf8-code *)

val merge_tree : tree -> tree -> tree
(** [merge_tree t1 t2] returns a tree with [t1] and [t2] as subtrees *)

val print : tree -> unit
(** [print t] prints [t] *)

val prefixe_bin : tree -> string
(** [prefixe_bin t] returns a string of the tree with prefix reading : the node are the string.. 

TODO : tu as changé la syntaxe de l'arbre avec les séparateurs et tout du coup je suis perdu : faudra voir ça ensemble*)

val huff_tab : tree -> (int * string) list
(** [huff_tab t] returns the list of pairs with the utf8-code and the Huffman code *)

val huff_tree : Hash_table.elem_hash list -> tree
(** [huff_tree l] returns the tree for Huffman algorithm *)