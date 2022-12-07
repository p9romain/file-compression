let occ_hash file =
  let hash = Hash_table.construct 1009 (Hash_table.Occ (-1, 0)) in
  let t, h1, h2 = hash in
  let rec aux1 file =
    try
      let c = input_char file in
      let utf_c = Uchar.to_int (Uchar.of_char c) in
      let ind, b = Hash_table.find hash utf_c in
      if b then
        begin
          t.(ind) <- Hash_table.Occ (Hash_table.char_elem_hash (t.(ind)), 1 + Hash_table.occ_elem_hash (t.(ind))) ;
        end
      else
        t.(ind) <- Hash_table.Occ (utf_c, 1) ;
      aux1 file ;
    with
    | End_of_file -> ()
    | _ -> ()
  in
  let () = aux1 file in
  let () = close_in file in
  hash

let file_to_huff_string hash file =
  let t, h1, h2 = hash in
  let rec aux file s =
    try
      let c = input_char file in
      let utf_c = Uchar.to_int (Uchar.of_char c) in
      let ind, _ = Hash_table.find hash utf_c in
      aux file (s ^ Hash_table.code_elem_hash (t.(ind)));
    with
    | End_of_file -> s
    | _ -> failwith "Error : how did you do this"
  in
  aux file ""

let write file_name s =
  try
    let file = open_out (file_name ^ ".huff") in
    let char_to_bit c =
      match c with
      | '0' -> 0
      | '1' -> 1
      | _ -> failwith "Must be a '0' or '1'"
    in
    let () = String.iter (fun c -> Bs.write_bit (Bs.of_out_channel file) (char_to_bit c)) s in
    close_out file
  with
  | Sys_error msg -> failwith msg
  | _ -> ()

let read s = ()