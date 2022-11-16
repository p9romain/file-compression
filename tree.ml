type 'a tree =
| L of 'a
| N of ('a tree) * ('a tree)

(* let val_leaf a =
  match a with
  | N (_) -> failwith "Must be a tree"
  | L (n) -> n

let left_tree a =
  match a with
  | L (_) -> failwith "Must be a leaf"
  | N ( (a1, a2) ) -> a1

let right_tree a =
  match a with
  | L (_) -> failwith "Must be a leaf"
  | N ( (a1, a2) ) -> a2 *)

let merge_tree a1 a2 = N( (a1, a2) )

let huff_tab a =
  let rec aux a n l =
    match a with
    | L (s) -> (s, n) :: l
    | N ( (a1, a2) ) ->
      let n1 = n ^ "0" in
      let l = aux a1 n1 l in
      let n2 = n ^ "1" in
      let l = aux a2 n2 l in 
      l
  in 
  aux a "" []

let huff_tree l = 
  let rec aux l = 
    match l with
    | [] -> failwith "Empty list"
    | (a, n) :: [] -> a
    | _ ->
      let (a1, n1), ll = Heap.remove_min l in
      let (a2, n2), l = Heap.remove_min ll in
      aux (((merge_tree a1 a2), n1+n2) :: l)
  in 
  aux l