let construct () =
  let h = Heap.empty 0 (fun x y -> compare x y) in
  let t = [1 ; 5 ; 3 ; 11 ; 4] in
  List.fold_left (Heap.add) h t

let print h =
  Printf.printf "| " ;
  Heap.print h (fun e -> Printf.printf "%d | " e) ;
  Printf.printf "\n"

let main () =
  let h = construct () in
  print h ;
  let min, h = Heap.remove_min h in
  Printf.printf "min = %d && " min ;
  print h ;
  Heap.add h 4 ;
  print h 

let () = main ()