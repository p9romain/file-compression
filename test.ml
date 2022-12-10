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
  Printf.printf "\n%s\n" (Tree.prefixe_bin tree)

let rec dec_to_bin n =
  if n = 0 then
    ""
  else if n mod 2 = 0 then
    (dec_to_bin (n/2)) ^ "0"
  else
    (dec_to_bin (n/2)) ^ "1"

let test_dec_to_bin () =
  Printf.printf "%s\n" (dec_to_bin 116)

let main () =
  test_heap ();
  test_dec_to_bin ();
  test_tree ()

let () = main ()


(* let () =
      let print_couple e =
        let a, b = e in
        Printf.printf "(";
        print a;
        Printf.printf ", %d)" b;
      in
      List.iter print_couple l;
      Printf.printf "\n";
    in *)