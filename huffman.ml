let decompress s = 
  let channel_in = open_in s in
  let stream_in = Bs.of_in_channel channel_in in
  let tree = Read_write.header_to_tree stream_in in
  let sep = Char.chr 47 in (* char : / *)
  let l = String.split_on_char sep s in (*"test_files/name.ext.hf" >> ["test_files" ; "name.ext.hf"]*)
  let l = List.rev l in (*["name.ext.hf" ; "test_files"]*)
  let file = List.hd l in (*"name.ext.hf"*)
  let l_file = String.split_on_char '.' file (*["name" ; "ext" ; "hf"]*) in
  match l_file with
  | [] | _ :: [] -> failwith "Given file isn't correct (not name.ext.hf)"
  | name :: ext :: l_file ->
    let file = "new_" ^ name ^ "." ^ ext in (*"new_name.ext"*)
    let l = List.rev (file :: List.tl l) in (*["test_files" ; "new_name.ext"]*)
    let s_new = String.concat (String.make 1 sep) l in (*"test_files/new_name.ext"*)
    let channel_out = open_out s_new in
    let _ = Bs.read_n_bits stream_in 23 in
    let () = Read_write.transcript_body tree stream_in channel_out in
    let () = close_in channel_in in
    close_out channel_out

let compress s = 
  let hash = Read_write.occ_hash s in
  let a, h1, h2 = hash in
  let heap = Hash_table.to_heap hash in
  let tree = Tree.huff_heap_to_tree heap in
  let s_tree = Tree.prefixe_bin tree in
  let l = Tree.huff_tree_to_list tree in
  let modify (n, bin) =
    let ind, _ = Hash_table.find (a, h1, h2) n in
    a.(ind) <- Hash_table.Code (n, bin)
  in
  let () = List.iter modify l in (*on modifie la table de hachage*)
  (*Pas stocker le text dans un string et réécrire petit à petit ?*)
  let s_file = Read_write.file_to_huff_string hash s in
  let sep_header_body = String.make 24 '1' in
  let s_total = s_tree ^ sep_header_body ^ s_file in
  Read_write.write s s_total