let construct_heap () =
  let hash = Read_write.occ_hash "text_files/test_text.txt" in
  Hash_table.to_heap hash

let test_heap () =
  let heap = construct_heap () in
  let aux e =
    Printf.printf "(";
    Tree.print (fst e) ;
    Printf.printf ", %d)" (snd e)
  in
  Heap.print heap aux;
  Printf.printf "\n"

let construct_tree heap = Tree.huff_heap_to_tree heap

let construct_tree () = construct_tree (construct_heap ())

let test_tree () =
  let tree = construct_tree () in
  Tree.print tree;
  Printf.printf "\n"

let test_decode_tree () =
  let channel_in = open_in "text_files/test_text.txt.hf" in
  let stream_in = Bs.of_in_channel channel_in in
  let tree = Read_write.header_to_tree stream_in in
  close_in channel_in;
  Tree.print tree

let test_print_compressed () =
  let () = Huffman.compress "text_files/test_text.txt" in
  let channel_in = open_in "text_files/test_text.txt.hf" in
  let stream = Bs.of_in_channel channel_in in
  let rec aux () =
    try
      let b = Bs.read_bit stream in
      Printf.printf "%d" b;
      aux ()
    with
    Bs.End_of_stream -> ()
    | Bs.Invalid_stream -> ()
  in
  aux ();
  close_in channel_in;
  Printf.printf "\n"

let main () =
  Printf.printf "Construction du tas pour \"satisfaisant\"\n" ;
  test_heap ();
  Printf.printf "\nConstruction de l'arbre d'Huffman\n" ;
  test_tree ();
  Printf.printf "\nCompression du fichier\n" ;
  test_print_compressed ();
  Printf.printf "\nConstruction de l'arbre stocké dans le fichier compressé (identique au premier)\n" ;
  test_decode_tree ();
  Printf.printf "\n"

let () = main ()