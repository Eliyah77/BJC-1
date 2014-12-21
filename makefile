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
bjc_imprim: pdf/bjc_imprim.pdf pdf/bjc_imprim_complet.pdf

pdf/bjc_imprim.pdf: tex/bjc_imprim.tex tex/bjc_2014/*.tex tex/bjc_2014/annexes/*.tex
	$(XELATEX) bjc_imprim
	$(XELATEX) bjc_imprim
	$(XELATEX) bjc_imprim

pdf/bjc_imprim_complet.pdf: pdf/annexes/*.pdf
	pdftk pdf/bjc_imprim.pdf \
		cat 1-r21 \
		output pdf/bjc_imprim_tmp.pdf
	pdftk \
		pdf/annexes/1_* \
		pdf/annexes/2_* \
		pdf/annexes/3_* \
		pdf/annexes/4_* \
		pdf/annexes/5_* \
		pdf/annexes/6_* \
		pdf/annexes/7_* \
		pdf/bjc_imprim_tmp.pdf \
		pdf/annexes/8_* \
		pdf/annexes/9_* \
		pdf/annexes/10_* \
		pdf/annexes/11_* \
		pdf/annexes/12_* \
		pdf/annexes/13_* \
		pdf/annexes/14_* \
		cat output pdf/bjc_imprim.pdf
	rm pdf/bjc_imprim_tmp.pdf

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
