type elem_tree = int

type tree =
| L of elem_tree
| N of tree * tree

(** UNUSED

let val_leaf t =
  match t with
  | N (_) -> failwith "Must be a leaf"
  | L (n) -> n

let left_tree t =
  match t with
  | L (_) -> failwith "Must be a tree"
  | N ( (t1, t2) ) -> t1

let right_tree t =
  match t with
  | L (_) -> failwith "Must be a tree"
  | N ( (t1, t2) ) -> t2

let print_leaf l = Printf.printf "%d" l *)

(* let print_leaf l = Printf.printf "%s" (String.make 1 (Uchar.to_char (Uchar.of_int l)))
 *)

let print_leaf l = Printf.printf "%d" l

let merge_tree t1 t2 = N((t1, t2))

let print t =
  let rec aux t =
    match t with
    | L (l) ->
      begin
        print_leaf l;
        Printf.printf " ";
      end
    | N (t1, t2) ->
      begin
        Printf.printf "_ ";
        aux t1;
        aux t2;
      end
  in aux t


let prefixe_bin t =
  let rec dec_to_bin n =
    if n = 0 then
      ""
    else if n mod 2 = 0 then
      (dec_to_bin (n/2)) ^ "0"
    else
      (dec_to_bin (n/2)) ^ "1"
  in
  let rec aux t =
    match t with
    | L (l) ->
      dec_to_bin l
    | N (t1, t2) ->
      let char_node = dec_to_bin 31 in
      let sep = String.make 24 '0' in
      char_node ^ sep ^ aux t1 ^ sep ^ aux t2
  in
  aux t ^ (String.make 24 '0')

let huff_tree_to_list t =
  let rec aux t n l =
    match t with
    | L (s) -> (s, n) :: l
    | N ( (t1, t2) ) ->
      let n1 = n ^ "0" in
      let l = aux t1 n1 l in
      let n2 = n ^ "1" in
      aux t2 n2 l 
  in 
  aux t "" []

let huff_heap_to_tree h =
  let rec aux h =
    if Heap.is_empty h then
      failwith "Empty heap"
    else if Heap.is_singleton h then
      Heap.find_min h
    else
      let (t1, n1), h = Heap.remove_min h in
      let (t2, n2), h = Heap.remove_min h in
      let t = merge_tree t1 t2 in
      let h = Heap.add h (t, n1+n2) in
      aux h
  in
  let t, _ = aux h in
  t

(* 
  let print_heap h =
    let print_elem_heap e =
      Printf.printf "( " ;
      print (fst e) ;
      Printf.printf " , " ;
      Printf.printf "%d ) | " (snd e)
    in
    Printf.printf "| " ;
    Heap.print h print_elem_heap ;
    Printf.printf "\n\n"
  in
 *)