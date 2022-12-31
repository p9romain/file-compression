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

let list_of_array a =
  let aux l e =
    match e with
    | Occ (c, _) | Code (c, _) ->
      if c = -1 then l
      else e :: l
  in
  Array.fold_left aux [] a

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