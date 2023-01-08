let construct () =
  let hash  = Hash_table.construct 7 (Hash_table.Occ(-1, 0)) in
  let t, h1, h2 = hash in
  let l = [ (Hash_table.Occ(25, 2)) ; (Hash_table.Occ(1263, 5)) ; (Hash_table.Occ(24, 263)) ; (Hash_table.Occ(152, 1)) ; (Hash_table.Occ(254, 24)) ] in
  let aux e =
    match e with
    | Hash_table.Occ(n, occ) -> 
      let ind, _ = Hash_table.find hash n in
      t.(ind) <- Hash_table.Occ(n, occ)
    | _ -> failwith "C'est pas ce qu'on a"
  in
  let () = List.iter aux l in
  hash

let modify hash =
  let t, h1, h2 = hash in
  let ind, b = Hash_table.find hash 152 in
  let () = Printf.printf "152 est dedans : %b\n" b in
  let () = t.(ind) <- Hash_table.Occ(Hash_table.char_elem_hash t.(ind), 12) in
  let ind, b = Hash_table.find hash 12 in
  let () = Printf.printf "12 n'est pas dedans : %b\n" b in
  let () = t.(ind) <- Hash_table.Occ(12, 1) in
  hash

let main () =
  let hash = construct () in
  let t, h1, h2 = hash in
  let () = Hash_table.print t in
  let () = Printf.printf "\n" in
  let hash = modify hash in
  let t, h1, h2 = hash in
  let () = Printf.printf "\n" in
  Hash_table.print t

let () = main ()