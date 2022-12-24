(* TODO : Les commandes !! *)

let main () =
  Huffman.compress "lorem_ipsum.txt";
  Huffman.decompress "lorem_ipsum.huff"
  
let () = main ()