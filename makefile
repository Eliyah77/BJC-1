# options de compilation
XELATEX ?= cd tex/ ; xelatex --output-directory=../pdf/

# Toutes
all: martin_1744 bjc_imprim bjc_internet

# Martin 1774
martin_1744: pdf/martin_1744.pdf

pdf/martin_1744.pdf: tex/martin_1744.tex tex/martin_1744/*.tex
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744

# BJC format imprim
bjc_imprim: pdf/bjc_imprim.pdf

pdf/bjc_imprim.pdf: tex/bjc_imprim.tex tex/bjc_2014/*.tex tex/bjc_2014/annexes/*.tex
	$(XELATEX) bjc_imprim
	$(XELATEX) bjc_imprim
	$(XELATEX) bjc_imprim

# BJC format internet
bjc_internet: pdf/bjc_internet.pdf

pdf/bjc_internet.pdf: tex/bjc_internet.tex tex/bjc_2014/*.tex tex/bjc_2014/annexes/*.tex
	$(XELATEX) bjc_internet
	$(XELATEX) bjc_internet
	$(XELATEX) bjc_internet

# supprime les fichiers généré par xelatex
clean: pdf/*.aux pdf/*.log pdf/*.out pdf/*.toc
	rm -rf pdf/*.aux
	rm -rf pdf/*.log
	rm -rf pdf/*.out
	rm -rf pdf/*.toc
