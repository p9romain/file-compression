let decompress _ = failwith "todo"
let compress s = 
  let a, h1, h2 = Read_write.occ_hash s in
  let l = Hash_table.list_of_array a in
  let tree = Tree.huff_tree l in
  let l = Tree.huff_tab tree in
  List.iter (fun e -> Printf.printf "(%d, %s)" (fst e) (snd e)) l