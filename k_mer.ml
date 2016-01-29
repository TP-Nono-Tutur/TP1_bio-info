let sub_seq sequence taille =
  let max = (String.length sequence) - taille in
  let rec aux acc i = 
    match i with
      i when i > max -> List.rev acc
    | _ -> let k_mer = String.sub sequence i taille  in
	   aux (k_mer::acc) (i + 1)
      in aux [] 0
	       
let extraire fasta taille =
  let rec aux fasta acc =
    match fasta with
      [] -> acc
    | (nom_seq, seq)::queue ->
       let k_mers = sub_seq seq taille in
       aux queue (acc @ k_mers)
  in aux fasta []

let rec membre liste element =
	match liste with
		| [] -> false
		| tete::_ when tete = element-> true
        | _::queue -> membre queue element 

let rec common_kmers_0 liste1 liste2 =
	match liste1 with
	    | [] -> []
	    | tete1 :: queue1 when membre liste2 tete1 -> tete1 :: common_kmers_0 queue1 liste2
		| _::queue -> common_kmers_0 queue liste2


