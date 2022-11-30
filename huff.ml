let main () = 
  let s = Tree.prefixe_bin (Tree.huff_tree [(25,2) ; (120,5) ; (4506,3) ; (1,1) ; (45,5)] ) in
  Printf.printf "%s" s
  
let () = main ()