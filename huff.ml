type elem = int
type tree =
| L of elem
| N of tree * tree

let main () = 
  let l = [(16, 3) ; (13, 2) ; (18, 1) ; (62, 2) ; (54, 3) ; (2, 1)] in
  let t = Tree.huff_tree l in
  Tree.print_tree t
  (* List.iter (fun (s, n) -> Printf.printf "%s : %d\n" s n) (Tree.huff_tab (Tree.huff_tree l)) (*Huffman.decompress "fichier"*) *)


let () = main ()