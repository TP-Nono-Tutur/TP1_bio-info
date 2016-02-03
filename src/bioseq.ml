let print_fasta_sequence file =
  let fasta = Fasta.of_file file in
  let p seq = print_endline (Fasta.get_name seq) in
  Fasta.iter p fasta



let print_fasta_stats file =
  let fasta = Fasta.of_file file in
  let p seq =
    let (name, dna) = (Fasta.get_name seq, Fasta.get_dna seq) in
    let length = String.length dna in
    Printf.printf "%s %d\n" name length in
  Fasta.iter p fasta

let list_k_mers longueur file =
  let fasta = Fasta.of_file file in
  List.iter print_endline (K_mer.list longueur fasta)


let common_kmers longueur fichier1 fichier2 =
  let fasta1 = Fasta.of_file fichier1
  and fasta2 = Fasta.of_file fichier2 in
  let k_mers1 = K_mer.list longueur fasta1 
  and k_mers2 = K_mer.list longueur fasta2 in
  let intersect = List_mp.intersect k_mers1 k_mers2 in
  List.iter print_endline intersect

let ratio_common_kmers longueur fichier1 fichier2 =
  let fasta1 = Fasta.of_file fichier1
  and fasta2 = Fasta.of_file fichier2 in
  let k_mers1 = K_mer.list longueur fasta1 
  and k_mers2 = K_mer.list longueur fasta2 in
  let intersect = List_mp.intersect k_mers1 k_mers2 in
  let ratio = Math.((List.length intersect) // (List.length k_mers1))
  in Printf.printf "%f\n" ratio
	    
let main =
  ratio_common_kmers 4 "test2.fasta" "test1.fasta"
	  
