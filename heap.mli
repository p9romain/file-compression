(**
type heap = { length : int ; tab : 'a array }
(** The type of heaps. Elements are ordered using generic comparison. *)

val empty : 'a -> heap
(** [empty] is the empty heap. *)

val is_empty : heap -> bool
(** [is_empty h] returns [true] if [h] contains zero element *)

val is_singleton : heap -> bool
(** [is_singleton h] returns [true] if [h] contains one element *)

val swap : heap -> int -> int -> unit
(** docu à faire *)

val add : 'a -> heap -> heap
(** [add e h] add element [e] to [h]. *)

val remove_min : heap -> 'a * heap
(** [remove_min h] returns the pair of the smallest elements of [h] w.r.t to 
    the generic comparison [<] and [h] where that element has been removed. *)

val find_min : heap -> 'a 
(** [find_min h] returns the smallest elements of [h] w.r.t to 
    the generic comparison [<] *)
*)


(* A voir si on change toujours pour un tas ou pas (je pense pas) *)



val find_min : ('a * 'b) list -> ('a * 'b)
(** [find_min l] returns the smallest elements of [l] w.r.t to 
    the generic comparison [<] *)

val remove_min : ('a * 'b) list -> ('a * 'b) * ('a * 'b) list
(** [remove_min l] returns the pair of the smallest elements of [l] w.r.t to 
    the generic comparison [<] and [l] where that element has been removed. *)