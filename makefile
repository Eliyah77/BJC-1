# options de compilation
XELATEX ?= cd tex/ ; xelatex --output-directory=../pdf/

# Toutes (limité à la BJC seule)
all: bjc

# Martin 1774
martin_1744: pdf/martin_1744.pdf

pdf/martin_1744.pdf: tex/martin_1744.tex tex/martin_1744/*.tex
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744

# BJC format eco imprim
bjc_123x180: pdf/bjc_123x180.pdf

pdf/bjc_123x180.pdf: tex/bjc_123x180.tex tex/bjc/*.tex tex/bjc/annexes/*.tex
	$(XELATEX) bjc_123x180
	$(XELATEX) bjc_123x180
	$(XELATEX) bjc_123x180

# BJC
bjc: pdf/bjc.pdf

pdf/bjc_tmp.pdf: tex/bjc.tex tex/bjc/*.tex tex/bjc/annexes/*.tex
	$(XELATEX) -jobname=bjc_tmp bjc
	$(XELATEX) -jobname=bjc_tmp bjc
	$(XELATEX) -jobname=bjc_tmp bjc

pdf/bjc_tmp_annexes.pdf: tex/bjc_annexes.tex tex/bjc/annexes/*.tex
	$(XELATEX) -jobname=bjc_tmp_annexes bjc_annexes
	$(XELATEX) -jobname=bjc_tmp_annexes bjc_annexes
	$(XELATEX) -jobname=bjc_tmp_annexes bjc_annexes

pdf/bjc.pdf: pdf/bjc_tmp.pdf pdf/bjc_tmp_annexes.pdf pdf/annexes/*.pdf
	pdftk \
		pdf/entetes/1_* \
		pdf/entetes/2_* \
		pdf/entetes/3_* \
		pdf/entetes/4_* \
		pdf/entetes/5_* \
		pdf/entetes/6_* \
		cat output pdf/bjc_tmp_1_entetes.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 1-2 output pdf/bjc_tmp_2_intro.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 3 output pdf/bjc_tmp_3_sommaire.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 5-219 output pdf/bjc_tmp_4_torah.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 221-631 output pdf/bjc_tmp_5_neviim.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 633-908 output pdf/bjc_tmp_6_ketouvim.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 910-1042 output pdf/bjc_tmp_7_evangiles.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 1044-1238 output pdf/bjc_tmp_8_testament.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 1241-1279 output pdf/bjc_tmp_9_dico.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		cat 1280 output pdf/bjc_tmp_10_concordance.pdf
	pdftk \
		pdf/bjc_tmp_annexes.pdf \
		cat r33-r26 output pdf/bjc_tmp_11_annexes1.pdf
	pdftk \
		pdf/annexes/10_* \
		pdf/annexes/11_* \
		pdf/annexes/12_* \
		pdf/annexes/13_* \
		pdf/annexes/14_* \
		pdf/annexes/15_* \
		pdf/annexes/16_* \
		pdf/annexes/17_* \
		pdf/annexes/18_* \
		pdf/annexes/19_* \
		pdf/annexes/20_* \
		pdf/annexes/21_* \
		pdf/annexes/22_* \
		pdf/annexes/23_* \
		pdf/annexes/24_* \
		pdf/annexes/25_* \
		pdf/annexes/26_* \
		pdf/annexes/27_* \
		pdf/annexes/28_* \
		pdf/annexes/29_* \
		pdf/annexes/30_* \
		pdf/annexes/31_* \
		pdf/annexes/32_* \
		pdf/annexes/33_* \
		pdf/annexes/34_* \
		cat output pdf/bjc_tmp_12_annexes2.pdf
	pdftk \
		pdf/bjc_tmp_1_* \
		pdf/bjc_tmp_2_* \
		pdf/bjc_tmp_3_* \
		pdf/entetes/Torah.pdf \
		pdf/bjc_tmp_4_* \
		pdf/entetes/Neviim.pdf \
		pdf/bjc_tmp_5_* \
		pdf/entetes/Ketouvim.pdf \
		pdf/bjc_tmp_6_* \
		pdf/entetes/Evangiles.pdf \
		pdf/bjc_tmp_7_* \
		pdf/entetes/Testament_de_Jesus.pdf \
		pdf/bjc_tmp_8_* \
		pdf/entetes/Aide.pdf \
		pdf/bjc_tmp_9_* \
		pdf/bjc_tmp_10_* \
		pdf/entetes/Annexes.pdf \
		pdf/bjc_tmp_11_* \
		pdf/bjc_tmp_12_* \
		cat output pdf/bjc_tmp.pdf
	pdftk \
		pdf/bjc_tmp.pdf \
		update_info_utf8 pdf/bjc_toc.info \
		output pdf/bjc.pdf
	rm pdf/bjc_tmp*

# supprime les fichiers généré par xelatex
clean: pdf/*.aux pdf/*.log  pdf/*.toc
	rm -rf pdf/*.aux
	rm -rf pdf/*.log
	rm -rf pdf/*.out
	rm -rf pdf/*.toc
