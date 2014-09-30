all: martin_1744 bjc_other bjc_current bjc_mix

martin_1744: ../pdf/martin_1744.pdf

../pdf/martin_1744.pdf: martin_1744.tex martin_1744/*.tex
	xelatex --output-directory=../pdf/ martin_1744
	xelatex --output-directory=../pdf/ martin_1744
	xelatex --output-directory=../pdf/ martin_1744

bjc_current: ../pdf/bjc_other.pdf

../pdf/bjc_current.pdf: bjc_current.tex bjc_2014/*.tex
	xelatex --output-directory=../pdf/ bjc_current
	xelatex --output-directory=../pdf/ bjc_current
	xelatex --output-directory=../pdf/ bjc_current

bjc_other: ../pdf/bjc_other.pdf

../pdf/bjc_other.pdf: bjc_other.tex bjc_2014/*.tex
	xelatex --output-directory=../pdf/ bjc_other
	xelatex --output-directory=../pdf/ bjc_other
	xelatex --output-directory=../pdf/ bjc_other

bjc_mix: ../pdf/bjc_mix.pdf

../pdf/bjc_mix.pdf: bjc_mix.tex bjc_2014/*.tex
	xelatex --output-directory=../pdf/ bjc_mix
	xelatex --output-directory=../pdf/ bjc_mix
	xelatex --output-directory=../pdf/ bjc_mix

clean:
	rm -rf ../pdf/*.aux
	rm -rf ../pdf/*.log
	rm -rf ../pdf/*.out
	rm -rf ../pdf/*.toc
