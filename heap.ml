(**
type heap = { length : int ; tab : 'a array }

let empty x0 = { length = 0 ; tab = Array.create 250 x0 }

let is_empty = ( heap.length = 0 )

let is_singleton heap = ( heap.length = 1 )

let swap heap i j =
  if i < 0 || j < 0 || i >= heap.length || j >= heap.length then
    failwith "Indexes out of bound"
  else
    let tmp = heap.tab.(i) in
    heap.tab.(i) <- heap.tab.(j) ;
    heap.tab.(j) <- tmp ;

let add x heap =
  let heap =
    if heap.length + 1 = Array.length heap.tab then
      { length = heap.length + 1 ; tab = Array.concat (heap.tab) (Array.create (Array.length heap.tab) heap.tab.(heap.length-1)) }
    else
      { length = heap.length + 1 ; tab = heap.tab }
  in
  heap.(heap.length-1) <- x ;
  let rec aux i =
    if i > 0 && heap.tab.((i-1)/2) > heap.tab.(i) then
      swap heap i ((i-1)/2) ;
      aux ((i-1)/2)
  in
  aux (heap.length-1) ;
  heap

let remove_min heap =
  let min = find_min heap in
  let () = swap heap 0 (heap.length-1) in 
  let heap = { length = heap.length - 1 ; tab = heap.tab } in
  let rec aux heap i b =
    if b then
      if 2*i+2 > heap.length-1 then
        aux heap i false
      else
        let f = 
          if heap.tab.(2*i+2) > heap.tab.(2*i+1) then
            2*i+1
          else
            2*i+2
        in
        if heap.tab.(i) > heap.tab.(f) then
          swap heap i f ;
          aux heap f b
        else
          aux heap i false
    else
      if 2*i+1 = heap.length-1 && heap.tab.(heap.length-1) < heap.tab.(i) then
        swap(i, heap.length-1)
  in
  aux heap 0 true ;
  (min, heap)


let find_min heap = heap.tab.(0)
*)

let find_min l =
  match l with
  | [] -> failwith "Empty list"
  | e :: ll ->
    let rec aux l min =
      match l with
      | [] -> min
      | e :: ll -> 
          if snd e >= snd min then
            aux ll min
          else
            aux ll e
  in
  aux ll e

let remove_min l =
  let min = find_min l in
  let rec aux l =
    match l with
    | [] -> []
    | e :: ll ->
      (* Comme on suppose les listes pas triées, et que l'on prend le premier minimum,
         alors on regarde la première valeur égale au minimum *)
      if snd e = snd min then (* On compare les occurences *)
        ll
      else
        e :: (aux ll)
  in
  (min, aux l)