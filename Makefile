EXE=bioseq.native

all:
	ocamlbuild -I src -I deps/ ${EXE}

get_deps:
	git clone https://github.com/altor/Module_perso.git deps/

clean:
	rm -R _build ${EXE}
