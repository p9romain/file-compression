open Hash_table

let decompress _ = failwith "todo"

let compress s = 
  let file = open_in s in
  let hash = Read_write.occ_hash file in
  let a, h1, h2 = hash in
  let l = Hash_table.list_of_array a in
  let tree = Tree.huff_tree l in
  let s_tree = Tree.prefixe_bin tree in
  let l = Tree.huff_tab tree in
  let modify (n, bin) =
    let ind, _ = Hash_table.find (a, h1, h2) n in
    a.(ind) <- Code (n, bin)
  in
  let () = List.iter modify l in
  let s_file = Read_write.file_to_huff_string hash file in
  let s_null = String.make 24 '0' in
  let s_total = s_tree ^ s_null ^ s_file in 
  let n_bourr = 8 - ((String.length s) mod 8) in
  let bourrage = String.make n_bourr '0' in
  Read_write.write s (bourrage ^ s_total)