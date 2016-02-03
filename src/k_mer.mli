type k_mer = string

(** [list n fasta] renvoi la liste de tout les k_mer de taille [n] du fasta [fasta]*)
val list : int -> Fasta.fasta -> k_mer list
