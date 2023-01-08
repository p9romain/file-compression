let construct_heap () =
  let hash = Read_write.occ_hash "test_text.txt" in
  let a, h1, h2 = hash in
  let heap = Hash_table.list_of_array a in
  heap

let test_heap () =
  let heap = construct_heap () in
  let aux e =
    Printf.printf "(";
    Hash_table.print_elem_hash e;
    Printf.printf ") ";
  in
  List.iter aux heap;
  Printf.printf "\n"

let construct_tree heap = Tree.huff_tree heap

let construct_tree () = construct_tree (construct_heap ())

let test_tree () =
  let tree = construct_tree () in
  Tree.print tree;
  Printf.printf "\n"

let test_decode_tree () =
  let channel_in = open_in "text_files/test_text.huff" in
  let stream_in = Bs.of_in_channel channel_in in
  let tree = Read_write.header_to_tree stream_in in
  close_in channel_in;
  Tree.print tree

let test_print_compressed () =
  let channel_in = open_in "test_text.huff" in
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
  test_heap ();
  test_tree ();
  test_print_compressed ()
  test_decode_tree ()

let () = main ()