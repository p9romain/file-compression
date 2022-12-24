let decompress s = 
  let channel_in = open_in s in
  let stream_in = Bs.of_in_channel channel_in in
  let tree = Read_write.header_to_tree stream_in in
  let s = (List.hd (String.split_on_char '.' s)) ^ ".txt" in
  let channel_out = open_out ("new_" ^ s) in
  let _ = Bs.read_n_bits stream_in 23 in
  let () = Read_write.transcript_body tree stream_in channel_out in
  let () = close_in channel_in in
  close_out channel_out

(*à changer*)
let compress s = 
  let hash = Read_write.occ_hash s in
  let a, h1, h2 = hash in
  let l = Hash_table.list_of_array a in
  let tree = Tree.huff_tree l in
  let s_tree = Tree.prefixe_bin tree in
  let l = Tree.huff_tab tree in
  let modify (n, bin) =
    let ind, _ = Hash_table.find (a, h1, h2) n in
    a.(ind) <- Hash_table.Code (n, bin)
  in
  let () = List.iter modify l in
  let s_file = Read_write.file_to_huff_string hash s in
  let sep_header_body = String.make 24 '1' in
  let s_total = s_tree ^ sep_header_body ^ s_file in
  Read_write.write s s_total