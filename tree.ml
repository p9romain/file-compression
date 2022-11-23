type elem_hash = (int * int)

type elem_tree = int

type tree =
| L of elem_tree
| N of tree * tree

let val_leaf a =
  match a with
  | N (_) -> failwith "Must be a leaf"
  | L (n) -> n

let print_leaf l = Printf.printf "%d" l

let left_tree a =
  match a with
  | L (_) -> failwith "Must be a tree"
  | N ( (a1, a2) ) -> a1

let right_tree a =
  match a with
  | L (_) -> failwith "Must be a tree"
  | N ( (a1, a2) ) -> a2

let merge_tree a1 a2 = N((a1, a2))

let huff_tab a =
  let rec aux a n l =
    match a with
    | L (s) -> (s, n) :: l
    | N ( (a1, a2) ) ->
      let n1 = n ^ "0" in
      let l = aux a1 n1 l in
      let n2 = n ^ "1" in
      aux a2 n2 l 
  in 
  aux a "" []

let print t =
  let rec aux t =
    match t with
    | L (l) ->
      begin
        print_leaf l;
        Printf.printf " ";
      end
    | N (a1, a2) ->
      begin
        Printf.printf "_ ";
        aux a1;
        aux a2;
      end
  in aux t

let huff_tree l =
  let rec aux l =
    match l with
    | [] -> failwith "Empty list"
    | (a, n) :: [] -> a
    | _ ->
      let (a1, n1), l = Heap.remove_min l in
      let (a2, n2), l = Heap.remove_min l in
      let t = merge_tree a1 a2 in
      aux ((t, n1+n2) :: l)
  in 
  aux (List.map (fun e -> (L(fst e) , snd e)) l)
