let extraire_nom_sequence ligne =
  String.sub ligne 1 ((String.length ligne) - 1)


let extraire fichier =
  let input = open_in fichier
  in let rec aux acc_fasta (nom_sequence, sequence) =
       try
	 match input_line input with
	   ligne when ligne.[0] == '>' ->
	   let nom_sequence2 = extraire_nom_sequence ligne in
	   aux ((nom_sequence, sequence)::acc_fasta) (nom_sequence2, "")
	 | ligne ->
	    aux acc_fasta (nom_sequence, ligne ^ sequence)
       with
	 End_of_file -> List.rev ((nom_sequence, sequence)::acc_fasta)
     in aux [] (extraire_nom_sequence (input_line input), "")
