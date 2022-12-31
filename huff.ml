let main () =
  if Array.length Sys.argv = 1 then
    Printf.printf "\n    You haven't given any arguments.\n    Have you tried './huff.exe --help' ?\n\n"
  else
    let help = "    A program who can compress a .txt file with the Huffman algorithm. The file can be decompressed after.\n\n    Options : \n        --compress @ARGS.txt or -c @ARGS.txt : compresses the file and create a @ARGS.hf compressed file \n        --decompress @ARGS.hf or -d @ARGS.hf : decompresses the file and create a new_@ARGS.txt decompressed file \n        --stats @ARGS or -s @ARGS : compresses a file and show some cool stats \n        --help or -h : show this message (hello !)" in
    if Sys.argv.(1) = "--help" || Sys.argv.(1) = "-h" then
      Printf.printf "\n%s\n\n" help

    else if Sys.argv.(1) = "--compress" || Sys.argv.(1) = "-c" then
      if Array.length Sys.argv = 2 then
        Printf.printf "\n    You haven't given any files.\n    Have you tried './huff.exe --help' ?\n\n"
      else
        Huffman.compress Sys.argv.(2)

    else if Sys.argv.(1) = "--decompress" || Sys.argv.(1) = "-d" then
      if Array.length Sys.argv = 2 then
        Printf.printf "\n    You haven't given any files.\n    Have you tried './huff.exe --help' ?\n\n"
      else
        Huffman.decompress Sys.argv.(2)

    else if Sys.argv.(1) = "--stats" || Sys.argv.(1) = "-s" then
      if Array.length Sys.argv = 2 then
        Printf.printf "\n    You haven't given any files.\n    Have you tried './huff.exe --help' ?\n\n"
      else
        Huffman.compress Sys.argv.(2)
        (* TODO : les stats *)

    else
      Printf.printf "\n    Your option isn't considered by this program.\n    Here's the help message :\n\n\n%s\n\n" help

let () = main ()