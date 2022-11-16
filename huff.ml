type 'a tree =
| L of 'a
| N of ('a tree) * ('a tree)

let main () = 
  let l = [(L("s") , 3) ; (L("i") , 2) ; (L("n") , 1) ; (L("t") , 2) ; (L("a") , 3) ; (L("f") , 1)] in
  List.iter (fun (s, b) -> Printf.printf "%s : %s\n" s b) (Tree.huff_tab (Tree.huff_tree l)) (*Huffman.decompress "fichier"*)


let () = main ()