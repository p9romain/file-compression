type elem_tree = int

type tree =
| L of elem_tree
| N of tree * tree

let val_leaf a =
  match a with
  | N (_) -> failwith "Must be a leaf"
  | L (n) -> n

let left_tree a =
  match a with
  | L (_) -> failwith "Must be a tree"
  | N ( (a1, a2) ) -> a1

let right_tree a =
  match a with
  | L (_) -> failwith "Must be a tree"
  | N ( (a1, a2) ) -> a2

let print_leaf l = Printf.printf "%d" l

let merge_tree a1 a2 = N((a1, a2))

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


let prefixe_bin a =
  let rec aux t =
    match t with
    | L (l) ->
      let rec dec_to_bin n =
        if n = 0 then
          ""
        else if n mod 2 = 0 then
          (dec_to_bin (n/2)) ^ "0"
        else
          (dec_to_bin (n/2)) ^ "1"
      in
      let n = 24 - (int_of_float ((Float.log ((float) l))/.(Float.log 2.) +. 1.)) in
      let s0 = String.make n '0' in
      s0 ^ dec_to_bin l
    | N (a1, a2) ->
      let sep = String.make 19 '0' ^ "11111" in
      sep ^ aux a1 ^ aux a2
  in
  aux a

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
  let aux1 e =
    match e with
    | Hash_table.Occ (c, n) -> (L(c), n)
    | Hash_table.Code _ -> failwith "WIP"
  in
  aux (List.map aux1 l)