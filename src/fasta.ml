type sequence = string * string
type fasta = sequence list

let make_sequence name dna_string =
  (name, dna_string)

let get_name seq =
  let (name, _) = seq in name

let get_dna seq =
  let (_, dna) = seq in dna

(* retire le chevron du nom d'une séquence *)
let remove_begin ligne =
  String.sub ligne 1 ((String.length ligne) - 1)

let of_file file =
  let input = open_in file
  in let rec aux fasta_acc seq_name dna_acc =
       try
	 match input_line input with
	 | ligne when ligne.[0] = '>' ->
	    let seq_name2 = remove_begin ligne in
	    let fasta_acc2 = 
	      match seq_name with 
		"" -> fasta_acc
	      | _ -> 
		 let seq = make_sequence seq_name dna_acc in
		 (seq::fasta_acc)
	    in
	    aux fasta_acc2 seq_name2 ""
	 | ligne ->
	    aux fasta_acc seq_name (ligne ^ dna_acc)
       with
       | End_of_file ->
	  let seq = make_sequence seq_name dna_acc
	  in List.rev (seq::fasta_acc)
     in aux [] "" ""

let iter = List.iter
let fold_left = List.fold_left
