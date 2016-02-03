
(** une séquence d'un fichier fasta *)
type sequence = string * string
		  
(** représentation d'un fichier fasta *)
type fasta = sequence list

(** [make_sequence n s] renvoi la sequence appellée [n] contenant la chaine d'ADN [s]*)
val make_sequence : string -> string -> sequence
		      
(** [get_name seq] renvoi le nom de la sequence [seq]*)
val get_name : sequence -> string

(** [get_dna seq] renvoi la chaine d'ADN de la sequence [seq]*)
val get_dna : sequence -> string

(** [iter f fasta] applique la fonction [f] sur chaque sequence de la structure [fasta]*)
val iter : (sequence -> unit) -> fasta -> unit

(** pli sur un fasta *)
val fold_left : ('a -> sequence -> 'a) -> 'a -> fasta -> 'a
					    
(** [of_file fichier] renvoi une structure fasta extraite à partir du fichier [fichier]*)
val of_file : string -> fasta
