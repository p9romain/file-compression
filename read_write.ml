let occ_hash s =
  let file = open_in s in
  let hash = Hash_table.construct 509 (Hash_table.Occ (-1, 0)) in
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

let file_to_huff_string hash s =
  let file = open_in s in
  let t, h1, h2 = hash in
  let rec aux file s =
    try
      let c = input_char file in
      let utf_c = Uchar.to_int (Uchar.of_char c) in
      let ind, _ = Hash_table.find hash utf_c in
      aux file (s ^ Hash_table.code_elem_hash (t.(ind)))
    with
    | End_of_file -> s
    | _ -> failwith "Error"
  in
  let s = aux file "" in
  let () = close_in file in
  s

let write file_name s =
  try
    let l = String.split_on_char '.' file_name in
    let file_name = List.hd l in
    let file = open_out (file_name ^ ".huff") in
    let stream = Bs.of_out_channel file in
    let char_to_bit c =
      match c with
      | '0' -> 0
      | '1' -> 1
      | _ -> failwith "Must be a '0' or '1'"
    in
    let () = String.iter (fun c -> Bs.write_bit stream (char_to_bit c)) s in
    Bs.finalize stream;
    close_out file
  with
  | Sys_error msg -> failwith msg
  | _ -> ()

let header_to_tree stream =
  let rec go_until_one i =
    try
      if Bs.read_bit stream <> 1 then
        go_until_one (i+1)
      else i
    with
    | Bs.End_of_stream -> i
    | Bs.Invalid_stream -> i
  in
  let _ = go_until_one 0 in
  let read () =
    let rec acc b j =
      if b = 1 then
        begin
          let i, n = aux 0 in
          if i = 0 then
            (1, 1 + n)
          else if i > 0 then
            (2*i, 2*i + n)
          else
            (i+1, n)
        end
      else
        begin
          let i, n = aux (j+1) in
          if i = 0 then
            (1, n)
          else if i > 0 then
            (2*i, n)
          else
            (i+1, n)
        end
    and aux j =
      if j = 24 then
        begin
          let t = go_until_one 0 in
          (t-j, 0)
        end
      else
        let b = Bs.read_bit stream in
        acc b j
    in
    let _, n = acc 1 0 in
    n
  in
  let rec aux2 () =
    let n = read () in
    if n = 31 then
      let t1 = aux2 () in
      let t2 = aux2 () in
      Tree.N(t1, t2)
    else 
      Tree.L(n)
  in
  aux2 ()

let transcript_body tree stream_in channel_out =
  let rec aux t =
    try
      match t with
      | Tree.N (a1, a2) ->
        begin
          let b = Bs.read_bit stream_in in
          if b = 0 then
            aux a1
          else
            aux a2
        end
      | Tree.L (n) ->
        begin
          let c = Uchar.to_char (Uchar.of_int n) in
          let () = output_char channel_out c in
          aux tree
        end
    with
    | Bs.End_of_stream -> ()
    | Bs.Invalid_stream -> ()
  in aux tree
