type 'a t = 'a list
(** The type of heaps. Elements are ordered using generic comparison. *)

val empty : 'a t
(** [empty] is the empty heap. *)

val is_singleton : 'a t -> bool
(** [is_singleton h] returns [true] if [h] contains one element *)

val is_empty : 'a t -> bool
(** [is_empty h] returns [true] if [h] contains zero element *)

(*val sort : 'a t -> 'a t
(** docu à faire *)*)

val add : 'a -> 'a t -> 'a t
(** [add e h] add element [e] to [h]. *)

val find_min : ('a * 'b) t -> ('a * 'b)
(** [find_min h] returns the smallest elements of [h] w.r.t to 
    the generic comparison [<] *)

val remove_min : ('a * 'b) t -> ('a * 'b) * ('a * 'b) t
(** [remove_min h] returns the pair of the smallest elements of [h] w.r.t to 
    the generic comparison [<] and [h] where that element has been removed. *)