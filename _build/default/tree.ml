type 'a tree =
| L of 'a
| N of ('a tree) * ('a tree)

let merge_tree a1 a2 = N(a1, a2)

(*let hauf_tree l =
  let rec aux l =
    match l with
    | [] -> failwith "Empty list"
    | e :: [] -> e
    | _ -> 
      let (e1, ll) = Heap.remove_min l in *)