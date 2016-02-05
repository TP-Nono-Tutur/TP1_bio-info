let print_fasta_sequence file =
  let fasta = Fasta.of_file file in
  let p seq = print_endline (Fasta.get_dna seq) 
    in  Fasta.iter p fasta

let print_fasta_stats file =
  let fasta = Fasta.of_file file in
  let p seq =
    let name, dna = (Fasta.get_name seq, Fasta.get_dna seq) in
    let length = String.length dna in
    Printf.printf "%s %d\n" name length in
  Fasta.iter p fasta

let list_k_mers_template f_list file =
  let fasta = Fasta.of_file file in
  List.iter print_endline (f_list fasta)
	    
let list_k_mers length file =
  list_k_mers_template (K_mer.list length) file

let list_spaced_k_mers seed file =
  list_k_mers_template (K_mer.list_spaced seed) file

let intersect_k_mers_template f_list file1 file2 =
  let fasta1 = Fasta.of_file file1
  and fasta2 = Fasta.of_file file2 in
  let k_mers1 = f_list fasta1 
  and k_mers2 = f_list fasta2
  in (k_mers1, k_mers2)

       
let common_k_mers_template f_list file1 file2 =
  let k_mers1, k_mers2 = intersect_k_mers_template f_list file1 file2 
  in let intersect = K_mer.common k_mers1 k_mers2
     in List.iter print_endline intersect
		  
let common_k_mers length file1 file2 = 
  common_k_mers_template (K_mer.list length) file1 file2

let common_spaced_k_mers seed file1 file2  =
  common_k_mers_template (K_mer.list_spaced seed) file1 file2

let ratio_common_k_mers_template f_list file1 file2 =
  let k_mers1, k_mers2 = intersect_k_mers_template f_list file1 file2
  in let intersect = K_mer.common k_mers1 k_mers2
     in let ratio = Math.((List.length intersect) // (List.length k_mers1))
	in Printf.printf "%f\n" ratio
  
let ratio_common_k_mers length file1 file2 =
  ratio_common_k_mers_template (K_mer.list length) file1 file2

let ratio_common_spaced_k_mers length file1 file2 =
  ratio_common_k_mers_template (K_mer.list_spaced length) file1 file2

let random_mutations nombre_mutations fichier =
  let fasta = Fasta.of_file fichier
  in Fasta.print (Fasta.random_mutation nombre_mutations fasta)

			       
let main =
  let commande = Sys.argv.(1) in
  match commande with
  | "print-fasta-sequences" ->
     let file = Sys.argv.(2)
     in print_fasta_sequence file
  | "print-fasta-stats" ->
     let file = Sys.argv.(2)
     in print_fasta_stats file
  | "list-kmers" ->
     let length = int_of_string(Sys.argv.(2))
     and file = Sys.argv.(3)
     in list_k_mers length file
  | "common-kmers" ->
     let length = int_of_string(Sys.argv.(2))
     and file1 = Sys.argv.(3)
     and file2 = Sys.argv.(4)
     in common_k_mers length file1 file2
  | "ratio-common-kmers" ->
     let length = int_of_string(Sys.argv.(2))
     and file1 = Sys.argv.(3)
     and file2 = Sys.argv.(4)
     in ratio_common_k_mers length file1 file2
  | "list-spaced-kmers" ->
     let seed = Sys.argv.(2)
     and file = Sys.argv.(3)
     in list_spaced_k_mers seed file
  | "common-spaced-kmers" ->
     let seed = Sys.argv.(2)
     and file1 = Sys.argv.(3)
     and file2 = Sys.argv.(4)
     in common_spaced_k_mers seed file1 file2
  | "ratio-common-spaced-kmers" ->
     let seed = Sys.argv.(2)
     and file1 = Sys.argv.(3)
     and file2 = Sys.argv.(4)
     in ratio_common_spaced_k_mers seed file1 file2
  | "random-mutations" ->
     Random.self_init ();
     let n = int_of_string(Sys.argv.(2))
     and file1 = Sys.argv.(3)
     in random_mutations n file1
  | _ -> prerr_endline "commande inconue"

  
