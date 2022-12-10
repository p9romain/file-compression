let main () =
  Huffman.compress "test_text.txt";
  Huffman.decompress "test_text.txt.huff"
  
let () = main ()