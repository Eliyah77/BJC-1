# options de compilation
XELATEX ?= xelatex --output-directory=./pdf/
SOURCES = $(wildcard *.tex)
DESTINATIONS = $(addprefix pdf/,$(addsuffix .pdf,$(basename ${SOURCES})))

# Toutes
all: ${DESTINATIONS}

# books
pdf/%.pdf: %.tex
	$(XELATEX) $<

# supprime les fichiers généré par xelatex
clean: pdf/*.aux pdf/*.log pdf/*.out
	rm -rf pdf/*.aux
	rm -rf pdf/*.log
	rm -rf pdf/*.out
