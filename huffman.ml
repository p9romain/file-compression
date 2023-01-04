let decompress s = 
  let channel_in = open_in s in
  let stream_in = Bs.of_in_channel channel_in in
  let tree = Read_write.header_to_tree stream_in in
  let sep = Char.chr 47 (* char : / *)
  let l = String.split_on_char sep s in
  let l = List.rev l in
  let file = List.hd l in
  let file = "new_" ^ file in
  let l = List.rev (file :: List.tl l) in
  let s_new = String.concat (String.make 1 sep) l in
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
  let () = List.iter modify l in
  (*Pas stocker le text dans un string et réécrire petit à petit ?*)
  let s_file = Read_write.file_to_huff_string hash s in
  let sep_header_body = String.make 24 '1' in
  let s_total = s_tree ^ sep_header_body ^ s_file in
  Read_write.write s s_total