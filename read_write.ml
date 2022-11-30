open Hash_table

let occ_hash s =
  let file = open_in s in
  let hash = Hash_table.construct 127 (Occ ( (-1, 0) )) in
  let t, h1, h2 = hash in
  let rec aux1 file =
    try
      let line = input_line file in
      let rec aux2 i =
        if i <> String.length line then
          let utf_c = Uchar.to_int (Uchar.of_char (String.get line i)) in
          let ind, b = Hash_table.find hash utf_c in
          if b then
            t.(ind) <- Occ ((fst (t.(ind)), 1 + snd (t.(ind)))) ;
          else
            t.(ind) <- Occ ((utf_c, 1)) ;
          aux2 (i+1) ;
      in 
      aux2 0 ;
      aux1 file ;
    with
    | End_of_file -> ()
    | _ -> ()
  in
  let () = aux1 file in
  let () = close_in file in
  (t, h1, h2)