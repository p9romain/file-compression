open Hash_table

let decompress _ = failwith "todo"

let compress s = 
  let hash = Read_write.occ_hash s in
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
  Hash_table.print a