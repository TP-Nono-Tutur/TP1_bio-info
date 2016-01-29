let extraire_nom_sequence ligne =
  String.sub ligne 1 ((String.length ligne) - 1)


let coller_ligne fichier =
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


let print_fasta_stats liste =
	match liste with
	    | [] -> ()
	    | tete :: queue -> 
		let (a,b) = tete in 
		let taille = String.length b
		in Printf.printf "%s %d\n" a taille 


let common_kmers longueur fichier1 fichier2 =
	let fasta1 = Fasta.extraire fichier1
	and fasta2 = Fasta.extraire fichier2
		in let liste1 = K_mer.extraire fasta1 longueur
			and liste2 = K_mer.extraire fasta2 longueur
			in let intersect = K_mer.common_kmers_0 liste1 liste2 in
			List.iter print_endline intersect



	    
let main =
	common_kmers 15 "ebola-t.fasta" "ebola-t.fasta"
	  
