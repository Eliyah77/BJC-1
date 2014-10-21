# options de compilation
XELATEX	?= cd tex/ ; xelatex --output-directory=../pdf/

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
books: books/*.pdf

books/*.pdf: books/*.tex tex/bjc_2014/*.tex
	cd books/ && xelatex 01-Genese.tex
	cd books/ && xelatex 02-Exode.tex
	cd books/ && xelatex 03-Levitique.tex
	cd books/ && xelatex 04-Nombres.tex
	cd books/ && xelatex 05-Deuteronome.tex
	cd books/ && xelatex 06-Josue.tex
	cd books/ && xelatex 07-Juges.tex
	cd books/ && xelatex 08-Ruth.tex
	cd books/ && xelatex 09-1Samuel.tex
	cd books/ && xelatex 10-2Samuel.tex
	cd books/ && xelatex 11-1Rois.tex
	cd books/ && xelatex 12-2Rois.tex
	cd books/ && xelatex 13-1Chroniques.tex
	cd books/ && xelatex 14-2Chroniques.tex
	cd books/ && xelatex 15-Esdras.tex
	cd books/ && xelatex 16-Nehemie.tex
	cd books/ && xelatex 17-Esther.tex
	cd books/ && xelatex 18-Job.tex
	cd books/ && xelatex 19-Psaumes.tex
	cd books/ && xelatex 20-Proverbes.tex
	cd books/ && xelatex 21-Ecclesiaste.tex
	cd books/ && xelatex 22-Cantiques.tex
	cd books/ && xelatex 23-Esaie.tex
	cd books/ && xelatex 24-Jeremie.tex
	cd books/ && xelatex 25-Lamentations.tex
	cd books/ && xelatex 26-Ezechiel.tex
	cd books/ && xelatex 27-Daniel.tex
	cd books/ && xelatex 28-Osee.tex
	cd books/ && xelatex 29-Joel.tex
	cd books/ && xelatex 30-Amos.tex
	cd books/ && xelatex 31-Abdias.tex
	cd books/ && xelatex 32-Jonas.tex
	cd books/ && xelatex 33-Michee.tex
	cd books/ && xelatex 34-Nahum.tex
	cd books/ && xelatex 35-Habakuk.tex
	cd books/ && xelatex 36-Sophonie.tex
	cd books/ && xelatex 37-Aggee.tex
	cd books/ && xelatex 38-Zacharie.tex
	cd books/ && xelatex 39-Malachie.tex
	cd books/ && xelatex 40-Matthieu.tex
	cd books/ && xelatex 41-Marc.tex
	cd books/ && xelatex 42-Luc.tex
	cd books/ && xelatex 43-Jean.tex
	cd books/ && xelatex 44-Actes.tex
	cd books/ && xelatex 45-Romains.tex
	cd books/ && xelatex 46-1Corinthiens.tex
	cd books/ && xelatex 47-2Corinthiens.tex
	cd books/ && xelatex 48-Galates.tex
	cd books/ && xelatex 49-Ephesiens.tex
	cd books/ && xelatex 50-Philippiens.tex
	cd books/ && xelatex 51-Colossiens.tex
	cd books/ && xelatex 52-1Thessaloniciens.tex
	cd books/ && xelatex 53-2Thessaloniciens.tex
	cd books/ && xelatex 54-1Timothee.tex
	cd books/ && xelatex 55-2Timothee.tex
	cd books/ && xelatex 56-Tite.tex
	cd books/ && xelatex 57-Philemon.tex
	cd books/ && xelatex 58-Hebreux.tex
	cd books/ && xelatex 59-Jacques.tex
	cd books/ && xelatex 60-1Pierre.tex
	cd books/ && xelatex 61-2Pierre.tex
	cd books/ && xelatex 62-1Jean.tex
	cd books/ && xelatex 63-2Jean.tex
	cd books/ && xelatex 64-3Jean.tex
	cd books/ && xelatex 65-Jude.tex
	cd books/ && xelatex 66-Apocalypse.tex
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
