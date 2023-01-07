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
    let file = open_out (file_name ^ ".hf") in
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
  try
    let rec aux () =
      let rec aux1 acc i =
        if i = 24 then
          acc
        else
          let b = Bs.read_bit stream in
          if b = 0 && acc = [] then
            aux1 acc (i+1)
          else
            aux1 (b :: acc) (i+1)
      in
      let l = aux1 [] 0 in
      let rec aux2 l =
        match l with
        | [] -> 0
        | e :: ll ->
           e + 2 * (aux2 ll)
      in
      let n = aux2 l in
      if n = 31 then
        let t1 = aux () in
        let t2 = aux () in
        Tree.N(t1, t2)
      else 
        Tree.L(n)
    in
    aux ()
  with
  | Bs.End_of_stream -> failwith "Impossible error"
  | Bs.Invalid_stream -> failwith "Impossible error"

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
