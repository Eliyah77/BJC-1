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

pdf/bjc_imprim_tmp.pdf: tex/bjc_imprim_tmp.tex tex/bjc_2014/*.tex tex/bjc_2014/annexes/*.tex
	$(XELATEX) bjc_imprim_tmp
	$(XELATEX) bjc_imprim_tmp
	$(XELATEX) bjc_imprim_tmp

pdf/bjc_imprim.pdf: pdf/bjc_imprim_tmp.pdf pdf/annexes/noir-blanc/*.pdf pdf/annexes/couleurs/*.pdf
	pdftk pdf/bjc_imprim_tmp.pdf \
		cat 1-r21 \
		output pdf/bjc_imprim_cut.pdf
	pdftk \
		pdf/annexes/couleurs/1_* \
		pdf/annexes/couleurs/2_* \
		pdf/annexes/couleurs/3_* \
		pdf/annexes/couleurs/4_* \
		pdf/annexes/couleurs/5_* \
		pdf/annexes/couleurs/6_* \
		pdf/annexes/couleurs/7_* \
		pdf/entetes/1_* \
		pdf/entetes/2_* \
		pdf/entetes/3_* \
		pdf/entetes/4_* \
		pdf/entetes/5_* \
		pdf/entetes/6_* \
		pdf/bjc_imprim_cut.pdf \
		pdf/annexes/noir-blanc/1_* \
		pdf/annexes/noir-blanc/2_* \
		pdf/annexes/noir-blanc/3_* \
		pdf/annexes/noir-blanc/4_* \
		pdf/annexes/noir-blanc/5_* \
		pdf/annexes/noir-blanc/6_* \
		pdf/annexes/noir-blanc/7_* \
		pdf/annexes/noir-blanc/8_* \
		pdf/annexes/noir-blanc/9_* \
		pdf/annexes/noir-blanc/10_* \
		pdf/annexes/noir-blanc/11_* \
		pdf/annexes/noir-blanc/12_* \
		pdf/annexes/noir-blanc/13_* \
		pdf/annexes/noir-blanc/14_* \
		pdf/annexes/noir-blanc/15_* \
		pdf/annexes/noir-blanc/16_* \
		pdf/annexes/noir-blanc/17_* \
		pdf/annexes/noir-blanc/18_* \
		pdf/annexes/noir-blanc/19_* \
		pdf/annexes/noir-blanc/20_* \
		pdf/annexes/couleurs/8_* \
		pdf/annexes/couleurs/9_* \
		pdf/annexes/couleurs/10_* \
		pdf/annexes/couleurs/11_* \
		pdf/annexes/couleurs/12_* \
		pdf/annexes/couleurs/13_* \
		pdf/annexes/couleurs/14_* \
		cat output pdf/bjc_imprim.pdf
	rm pdf/bjc_imprim_cut.pdf

# BJC format internet
bjc_internet: pdf/bjc_internet.pdf

pdf/bjc_internet_tmp.pdf: tex/bjc_internet_tmp.tex tex/bjc_2014/*.tex tex/bjc_2014/annexes/*.tex
	$(XELATEX) bjc_internet_tmp
	$(XELATEX) bjc_internet_tmp
	$(XELATEX) bjc_internet_tmp

pdf/bjc_internet.pdf: pdf/bjc_internet_tmp.pdf pdf/annexes/noir-blanc/*.pdf pdf/annexes/couleurs/*.pdf
	pdftk pdf/bjc_internet_tmp.pdf \
		cat 1-r21 \
		output pdf/bjc_internet_cut.pdf
	pdftk \
		pdf/entetes/1_* \
		pdf/entetes/2_* \
		pdf/entetes/3_* \
		pdf/entetes/4_* \
		pdf/entetes/5_* \
		pdf/entetes/6_* \
		pdf/bjc_internet_cut.pdf \
		pdf/annexes/noir-blanc/1_* \
		pdf/annexes/noir-blanc/2_* \
		pdf/annexes/noir-blanc/3_* \
		pdf/annexes/noir-blanc/4_* \
		pdf/annexes/noir-blanc/5_* \
		pdf/annexes/noir-blanc/6_* \
		pdf/annexes/noir-blanc/7_* \
		pdf/annexes/noir-blanc/8_* \
		pdf/annexes/noir-blanc/9_* \
		pdf/annexes/noir-blanc/10_* \
		pdf/annexes/noir-blanc/11_* \
		pdf/annexes/noir-blanc/12_* \
		pdf/annexes/noir-blanc/13_* \
		pdf/annexes/noir-blanc/14_* \
		pdf/annexes/noir-blanc/15_* \
		pdf/annexes/noir-blanc/16_* \
		pdf/annexes/noir-blanc/17_* \
		pdf/annexes/noir-blanc/18_* \
		pdf/annexes/noir-blanc/19_* \
		pdf/annexes/noir-blanc/20_* \
		pdf/annexes/couleurs/1_* \
		pdf/annexes/couleurs/2_* \
		pdf/annexes/couleurs/3_* \
		pdf/annexes/couleurs/4_* \
		pdf/annexes/couleurs/5_* \
		pdf/annexes/couleurs/6_* \
		pdf/annexes/couleurs/7_* \
		pdf/annexes/couleurs/8_* \
		pdf/annexes/couleurs/9_* \
		pdf/annexes/couleurs/10_* \
		pdf/annexes/couleurs/11_* \
		pdf/annexes/couleurs/12_* \
		pdf/annexes/couleurs/13_* \
		pdf/annexes/couleurs/14_* \
		cat output pdf/bjc_internet.pdf
	rm pdf/bjc_internet_cut.pdf

# supprime les fichiers généré par xelatex
clean: pdf/*.aux pdf/*.log pdf/*.out pdf/*.toc
	rm -rf pdf/*.aux
	rm -rf pdf/*.log
	rm -rf pdf/*.out
	rm -rf pdf/*.toc
