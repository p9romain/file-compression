let occ_hash s =
  let file = open_in s in
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

let file_to_huff_string hash s =
  let file = open_in s in
  let t, h1, h2 = hash in
  let rec aux file s =
    try
      let c = input_char file in
      let utf_c = Uchar.to_int (Uchar.of_char c) in
      let ind, _ = Hash_table.find hash utf_c in
      aux file (s ^ Hash_table.code_elem_hash (t.(ind)));
    with
    | End_of_file -> s
    | _ -> failwith "Error"
  in
  let s = aux file "" in
  let () = close_in file in 
  s

let write file_name s =
  try
    (*let _ = String.split_on_char '.' file_name in*)
    let file = open_out (file_name ^ ".huff") in
    let stream = Bs.of_out_channel file in
    let char_to_bit c =
      match c with
      | '0' -> 0
      | '1' -> 1
      | _ -> failwith "Must be a '0' or '1'"
    in
    let () = String.iter (fun c -> Bs.write_bit stream (char_to_bit c)) s in
    close_out file
  with
  | Sys_error msg -> failwith msg
  | _ -> ()

let header_to_tree channel_in =
  (* Ouverture du fichier à lire*)
  let stream = Bs.of_in_channel channel_in in
  (*Pour trouver le bourrage : on lit jusqu'à trouver des 1 car le 
  caractères de la racine de l'arbre est 00000000000000000000000000011111*)
  let rec aux1 c =
    if c <> 0 then
      let n = Bs.read_bit stream in
      if n = 1 then
        aux1 (c-1)
      else
        aux1 c
  in
  let () = aux1 5 in
  let rec aux2 =
    (* On lit 24 par 24 bits *)
    let n = Bs.read_n_bits stream 24 in
    (* Caractères null = séparateur entre arbre et texte *)
    if n <> 0 then
      (* Caractères sép = représente un noeud *)
      if n = 31 then
        Tree.N(aux2, aux2)
      else 
        Tree.L(n)
    else
      (*faut renvoyer quelque chose ici, c'est obligé :
      comment construire l'arbre alors......*)
  in
  (* Création de la racine et construction préfixe *)
  Tree.N(aux2, aux2)

let trancript_body tree channel_in channel_out =
  let stream_in = Bs.of_in_channel channel_in in
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
          let c = Uchar.of_int n in
          let () = output_char channel_out c in
          aux tree
        end
    with
    | End_of_file -> ()
  in aux tree