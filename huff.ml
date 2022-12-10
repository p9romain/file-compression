let main () =
  Huffman.compress "lorem_ipsum.txt";
  Huffman.decompress "lorem_ipsum.txt.huff"
  
let () = main ()