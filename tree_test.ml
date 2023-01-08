let construct () =
  Tree.N(
    Tree.N(
      Tree.N(
        Tree.N(
          Tree.L(1),
          Tree.L(4)
        ), 
        Tree.L(23)
      ),
      Tree.N(
        Tree.L(12),
        Tree.L(1)
      )
    ), 
    Tree.N(
      Tree.L(6),
      Tree.N(
        Tree.L(2),
        Tree.L(5)
      )
    )
  )

let main () =
  let a = construct () in
  let () = Tree.print a in
  let () = Printf.printf "\n" in
  let a1 = Tree.merge_tree a (Tree.N(Tree.L(-1), Tree.L(-1))) in
  let () = Tree.print a1 in
  Printf.printf "\n"

let () = main ()