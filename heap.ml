type 'a heap = { length : int ; tab : 'a array ; comp : ('a -> 'a -> int) }

let empty x0 f = { length = 0 ; tab = Array.create 250 x0 ; comp = f }

let is_empty heap = ( heap.length = 0 )

let is_singleton heap = ( heap.length = 1 )

let swap heap i j =
  if i < 0 || j < 0 || i >= heap.length || j >= heap.length then
    failwith "Indexes out of bound"
  else
    let tmp = heap.tab.(i) in
    heap.tab.(i) <- heap.tab.(j) ;
    heap.tab.(j) <- tmp

let add heap x =
  let heap =
    if heap.length + 1 = Array.length heap.tab then
      { length = heap.length + 1 ; tab = Array.concat [heap.tab ; Array.create (Array.length heap.tab) heap.tab.(heap.length-1)] ; comp = heap.comp }
    else
      { length = heap.length + 1 ; tab = heap.tab ; comp = heap.comp }
  in
  heap.tab.(heap.length-1) <- x ;
  let rec aux i =
    if i > 0 && heap.comp heap.tab.(i) heap.tab.((i-1)/2) < 0 then
      begin
        swap heap i ((i-1)/2) ;
        aux ((i-1)/2);
      end
  in
  aux (heap.length-1) ;
  heap

let find_min heap = heap.tab.(0)

let remove_min heap =
  let min = find_min heap in
  let () = swap heap 0 (heap.length-1) in 
  let heap = { length = heap.length - 1 ; tab = heap.tab ; comp = heap.comp } in
  let rec aux heap i b =
    if b then
      if 2*i+2 > heap.length-1 then
        aux heap i false
      else
        let f = 
          if heap.comp heap.tab.(2*i+1) heap.tab.(2*i+2) < 0 then
            2*i+1
          else
            2*i+2
        in
        if heap.comp heap.tab.(f) heap.tab.(i) < 0 then
          begin
            swap heap i f ;
            aux heap f b
          end
        else
          aux heap i false
    else
      if 2*i+1 = heap.length-1 && heap.comp heap.tab.(heap.length-1) heap.tab.(i) < 0 then
        swap heap i (heap.length-1)
  in
  aux heap 0 true ;
  (min, heap)

let print heap f = Array.iter f (Array.sub heap.tab 0 heap.length)