type elem_hash = int * int

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

let find (t, h1, h2) x =
  let i = h1 x in
  let rec aux i =
    if fst (t.(i)) = -1 then
      (i, false)
    else if fst (t.(i)) = x then 
      (i, true)
    else
      aux ((i + h2 x) mod (Array.length t))
  in aux i

let incr t i = t.(i) <- (fst (t.(i)), 1 + snd (t.(i)))

let list_of_array t =
  Array.fold_left (fun l e -> if fst e = -1 then l else e :: l) [] t

let print t = Array.iter (fun e -> Printf.printf "%d, occ = %d\n" (fst e) (snd e)) t