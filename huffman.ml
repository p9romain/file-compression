let decompress s = 
  let channel_in = open_in s in
  let tree = Read_write.header_to_tree channel_in in
  (*let channel_out = open_out ("new_" ^ s) in
  let () = Read_write.transcript_body tree channel_in channel_out in
  let () = close_in channel_in in
  close_out channel_out*)
  Tree.print tree

(*à changer*)
let compress s = 
  let hash = Read_write.occ_hash s in
  let a, h1, h2 = hash in
  let l = Hash_table.list_of_array a in
  let tree = Tree.huff_tree l in
  let () = Tree.print tree in
  let s_tree = Tree.prefixe_bin tree in
  let l = Tree.huff_tab tree in
  let modify (n, bin) =
    let ind, _ = Hash_table.find (a, h1, h2) n in
    a.(ind) <- Hash_table.Code (n, bin)
  in
  let () = List.iter modify l in
  let s_file = Read_write.file_to_huff_string hash s in
  let s_null = String.make 24 '0' in
  let s_total = s_tree ^ s_null ^ s_file in 
  let n_bourr = 8 - ((String.length s_total) mod 8) in
  let bourrage = String.make n_bourr '0' in
  Read_write.write s (bourrage ^ s_total)