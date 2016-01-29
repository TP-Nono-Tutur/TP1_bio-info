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

let main =
  let fasta = Fasta.coller_ligne "fichier"
  in extraire fasta 2
