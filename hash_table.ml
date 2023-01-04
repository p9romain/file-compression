type elem_hash = 
| Occ of (int * int) 
| Code of (int * string)

type hash = elem_hash array * (int -> int) * (int -> int)

let hash_map_1 n i =
  let phi = 1.6180339887498948 in
  let i = float i *. phi in
  let i = i -. float (int_of_float i) in
  let i = i *. float n in
  int_of_float i

let hash_map_2 n i =
  n - (i mod n)

let construct n x0 =
  let hash1 = hash_map_1 n in
  let hash2 = hash_map_2 (Random.int n) in
  (Array.create n x0, hash1, hash2)

let find (a, h1, h2) x =
  let i = h1 x in
  let rec aux i =
    match a.(i) with
    | Occ (c, _) | Code (c, _) ->
      if c = -1 then
        (i, false)
      else if c = x then 
        (i, true)
      else
        aux ((i + h2 x) mod (Array.length a))
  in aux i

let to_heap hash =
  let a, h1, h2 = hash in
  let heap = Heap.empty (Tree.L(0), 0) (fun x y -> compare (snd x) (snd y)) in
  let aux h e =
    match e with
    | Code _ -> failwith "Must be a list of Hash_table.Code, not Hash_table.Occ."
    | Occ (c, n) ->
      if c = -1 then h
      else Heap.add h (Tree.L(c), n)
  in
  Array.fold_left aux heap a

let print_elem_hash e =
  match e with
  | Occ (c, n) -> Printf.printf "%d, occ = %d" c n
  | Code (c, s) -> Printf.printf "%d, code = %s" c s

let print a =
  let aux e =
    print_elem_hash e;
    Printf.printf "\n";
  in Array.iter aux a

let char_elem_hash e =
  match e with
  | Occ (c, _) | Code (c, _) -> c

let occ_elem_hash e =
  match e with
  | Occ (_, c) -> c
  | _ -> failwith "Argument must be an element of type Occ"

let code_elem_hash e =
  match e with
  | Code (_, c) -> c
  | _ -> failwith "Argument must be an element of type Code"