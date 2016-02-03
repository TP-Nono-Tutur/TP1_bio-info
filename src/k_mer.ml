type k_mer = string

let sub_seq dna length =
  let max = (String.length dna) - length in
  let rec aux acc i = 
    match i with
      i when i > max -> List.rev acc
    | _ -> let k_mer = String.sub dna i length  in
	   aux (k_mer::acc) (i + 1)
      in aux [] 0
	       
let list length fasta =
  Fasta.fold_left
    (fun acc seq ->
    let dna = Fasta.get_dna seq in
    let k_mers = sub_seq dna length in
    (acc @ k_mers))
    []
    fasta
