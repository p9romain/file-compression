type 'a t = 'a list

let empty = []

let is_singleton l = 
  match l with
  | e :: empty -> true
  | _ -> false

let is_empty l = (l = [])

let add x l = x :: l

let find_min l =
  match l with
  | [] -> failwith "Empty list"
  | e :: ll ->
    let rec aux l min =
      match l with
      | [] -> min
      | e :: ll -> 
          if snd e > snd min then
            aux ll min
          else
            aux ll e
    in
    aux ll e

let remove_min l =
  let min = find_min l in
  let rec aux l acc =
    match l with
    | [] -> (min, acc)
    | e :: ll ->
      (* Comme on suppose les listes pas triées, et que l'on prend le premier minimum,
         alors on regarde la première valeur égale au minimum *)
      if snd e = snd min then
        aux ll acc
      else
        aux ll (e :: acc)
  in
  aux l [] 