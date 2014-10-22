# options de compilation
SRC = $(wildcard *.tex)
OBJ = $(SRC:.tex=.pdf)

# Toutes
all: books

books: $(OBJ)

# BJC livre individuel
%.pdf: %.tex ../tex/bjc_2014/%.tex
	xelatex $<
	xelatex $<
	xelatex $<

# supprime les fichiers généré par xelatex
clean: *.aux *.log *.out *.toc
	rm -rf *.aux
	rm -rf *.log
	rm -rf *.out
	rm -rf *.toc
