# options de compilation
XELATEX ?= cd tex/ ; xelatex --output-directory=../pdf/
XELATEXBOOKS ?= cd tex/books/ ; xelatex --output-directory=../../pdf/books/

# Toutes
all: bjc_current

# Martin 1774
martin_1744: pdf/martin_1744.pdf

pdf/martin_1744.pdf: tex/martin_1744.tex tex/martin_1744/*.tex
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744
	$(XELATEX) martin_1744

# BJC format current
bjc_current: pdf/bjc_current.pdf

pdf/bjc_current.pdf: tex/bjc_current.tex tex/bjc_2014/*.tex
	$(XELATEX) bjc_current
	$(XELATEX) bjc_current
	$(XELATEX) bjc_current

# BJC format other
bjc_other: pdf/bjc_other.pdf

pdf/bjc_other.pdf: tex/bjc_other.tex tex/bjc_2014/*.tex
	$(XELATEX) bjc_other
	$(XELATEX) bjc_other
	$(XELATEX) bjc_other

# BJC format mixte
bjc_mix: pdf/bjc_mix.pdf

pdf/bjc_mix.pdf: tex/bjc_mix.tex tex/bjc_2014/*.tex
	$(XELATEX) bjc_mix
	$(XELATEX) bjc_mix
	$(XELATEX) bjc_mix

# BJC livre individuel
books: tex/books/*.tex tex/bjc_2014/*.tex
	for book in tex/books/*.tex ; do \
	$(XELATEXBOOKS) 01-Genese.tex
	$(XELATEXBOOKS) 02-Exode.tex
	$(XELATEXBOOKS) 03-Levitique.tex
	$(XELATEXBOOKS) 04-Nombres.tex
	$(XELATEXBOOKS) 05-Deuteronome.tex
	$(XELATEXBOOKS) 06-Josue.tex
	$(XELATEXBOOKS) 07-Juges.tex
	$(XELATEXBOOKS) 08-Ruth.tex
	$(XELATEXBOOKS) 09-1Samuel.tex
	$(XELATEXBOOKS) 10-2Samuel.tex
	$(XELATEXBOOKS) 11-1Rois.tex
	$(XELATEXBOOKS) 12-2Rois.tex
	$(XELATEXBOOKS) 13-1Chroniques.tex
	$(XELATEXBOOKS) 14-2Chroniques.tex
	$(XELATEXBOOKS) 15-Esdras.tex
	$(XELATEXBOOKS) 16-Nehemie.tex
	$(XELATEXBOOKS) 17-Esther.tex
	$(XELATEXBOOKS) 18-Job.tex
	$(XELATEXBOOKS) 19-Psaumes.tex
	$(XELATEXBOOKS) 20-Proverbes.tex
	$(XELATEXBOOKS) 21-Ecclesiaste.tex
	$(XELATEXBOOKS) 22-Cantiques.tex
	$(XELATEXBOOKS) 23-Esaie.tex
	$(XELATEXBOOKS) 24-Jeremie.tex
	$(XELATEXBOOKS) 25-Lamentations.tex
	$(XELATEXBOOKS) 26-Ezechiel.tex
	$(XELATEXBOOKS) 27-Daniel.tex
	$(XELATEXBOOKS) 28-Osee.tex
	$(XELATEXBOOKS) 29-Joel.tex
	$(XELATEXBOOKS) 30-Amos.tex
	$(XELATEXBOOKS) 31-Abdias.tex
	$(XELATEXBOOKS) 32-Jonas.tex
	$(XELATEXBOOKS) 33-Michee.tex
	$(XELATEXBOOKS) 34-Nahum.tex
	$(XELATEXBOOKS) 35-Habakuk.tex
	$(XELATEXBOOKS) 36-Sophonie.tex
	$(XELATEXBOOKS) 37-Aggee.tex
	$(XELATEXBOOKS) 38-Zacharie.tex
	$(XELATEXBOOKS) 39-Malachie.tex
	$(XELATEXBOOKS) 40-Matthieu.tex
	$(XELATEXBOOKS) 41-Marc.tex
	$(XELATEXBOOKS) 42-Luc.tex
	$(XELATEXBOOKS) 43-Jean.tex
	$(XELATEXBOOKS) 44-Actes.tex
	$(XELATEXBOOKS) 45-Romains.tex
	$(XELATEXBOOKS) 46-1Corinthiens.tex
	$(XELATEXBOOKS) 47-2Corinthiens.tex
	$(XELATEXBOOKS) 48-Galates.tex
	$(XELATEXBOOKS) 49-Ephesiens.tex
	$(XELATEXBOOKS) 50-Philippiens.tex
	$(XELATEXBOOKS) 51-Colossiens.tex
	$(XELATEXBOOKS) 52-1Thessaloniciens.tex
	$(XELATEXBOOKS) 53-2Thessaloniciens.tex
	$(XELATEXBOOKS) 54-1Timothee.tex
	$(XELATEXBOOKS) 55-2Timothee.tex
	$(XELATEXBOOKS) 56-Tite.tex
	$(XELATEXBOOKS) 57-Philemon.tex
	$(XELATEXBOOKS) 58-Hebreux.tex
	$(XELATEXBOOKS) 59-Jacques.tex
	$(XELATEXBOOKS) 60-1Pierre.tex
	$(XELATEXBOOKS) 61-2Pierre.tex
	$(XELATEXBOOKS) 62-1Jean.tex
	$(XELATEXBOOKS) 63-2Jean.tex
	$(XELATEXBOOKS) 64-3Jean.tex
	$(XELATEXBOOKS) 65-Jude.tex
	$(XELATEXBOOKS) 66-Apocalypse.tex
	rm -rf books/*.aux
	rm -rf books/*.log
	rm -rf books/*.out
	rm -rf books/*.toc

# supprime les fichiers généré par xelatex
clean: pdf/*.aux pdf/*.log pdf/*.out pdf/*.toc
	rm -rf pdf/*.aux
	rm -rf pdf/*.log
	rm -rf pdf/*.out
	rm -rf pdf/*.toc
