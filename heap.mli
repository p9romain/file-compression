(**
type heap = { length : int ; heap : 'a array }
(** The type of heaps. Elements are ordered using generic comparison. *)

val empty : heap
(** [empty] is the empty heap. *)

val is_singleton : heap -> bool
(** [is_singleton h] returns [true] if [h] contains one element *)

val is_empty : heap -> bool
(** [is_empty h] returns [true] if [h] contains zero element *)

val add : 'a -> heap -> heap
(** [add e h] add element [e] to [h]. *)

val remove_min : heap -> 'a * heap
(** [remove_min h] returns the pair of the smallest elements of [h] w.r.t to 
    the generic comparison [<] and [h] where that element has been removed. *)

val find_min : heap -> 'a
(** [find_min h] returns the smallest elements of [h] w.r.t to 
    the generic comparison [<] *)
*)

val find_min : ('a * 'b) list -> ('a * 'b)
(** [find_min h] returns the smallest elements of [h] w.r.t to 
    the generic comparison [<] *)

val remove_min : ('a * 'b) list -> ('a * 'b) * ('a * 'b) list
(** [remove_min h] returns the pair of the smallest elements of [h] w.r.t to 
    the generic comparison [<] and [h] where that element has been removed. *)