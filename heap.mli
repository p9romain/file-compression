type 'a heap = { length : int ; tab : 'a array ; comp : ('a -> 'a -> int) }
(** The type of heaps. Elements are ordered using generic comparison. *)

val empty : 'a -> ('a -> 'a -> int) -> 'a heap
(** [empty] is the empty heap. *)

val is_empty : 'a heap -> bool
(** [is_empty h] returns [true] if [h] contains zero element *)

val is_singleton : 'a heap -> bool
(** [is_singleton h] returns [true] if [h] contains one element *)

val swap : 'a heap -> int -> int -> unit
(** docu à faire *)

val add : 'a heap -> 'a -> 'a heap
(** [add e h] add element [e] to [h]. *)

val find_min : 'a heap -> 'a 
(** [find_min h] returns the smallest elements of [h] w.r.t to 
    the generic comparison [<] *)

val remove_min : 'a heap -> 'a * 'a heap
(** [remove_min h] returns the pair of the smallest elements of [h] w.r.t to 
    the generic comparison [<] and [h] where that element has been removed. *)

val print : 'a heap -> ('a -> unit) -> unit
(** [print heap f] print [heap] in the right order of tab applying a print function [f] to each element *)