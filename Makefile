

################################
#
# Makefile for thesis
#
################################


inputs_tex   := $(wildcard *.tex) $(wildcard */*.tex) 
graphics_eps := $(wildcard figures/*.eps) $(wildcard */figures/*.eps) $(wildcard */figures/*/*.eps)
graphics_pdf := $(wildcard figures/*.pdf) $(wildcard */figures/*.pdf) $(wildcard */figures/*/*.pdf)
graphics_png := $(wildcard figures/*.png) $(wildcard */figures/*.png) $(wildcard */figures/*/*.png)

graphics_epstopdf := $(patsubst %.eps,%.pdf,$(graphics_eps))

#main.pdf: $(inputs_tex) $(graphics_eps) $(graphics_epstopdf) $(graphics_pdf) $(graphics_png) Bibliography.bib *.bst
main.pdf: $(inputs_tex) $(graphics_eps) $(graphics_epstopdf) $(graphics_pdf) $(graphics_png) Bibliography.bib
	./epstopdfList.sh ${?}
	pdflatex main.tex	
	bibtex main.aux
	pdflatex main.tex
	pdflatex main.tex

$(graphics_epstopdf):
	epstopdf $(patsubst %.pdf,%.eps,$(@))

figures: $(graphics_eps)
	./epstopdfList.sh ${?}

view: main.pdf
	acroread main.pdf

quick: $(inputs_tex) $(graphics_eps) $(graphics_epstopdf) $(graphics_pdf)$(graphics_png) Bibliography.bib
	./epstopdfList.sh ${?}
	pdflatex main.tex
	touch quick

quickview: $(inputs_tex) $(graphics_eps) $(graphics_epstopdf) $(graphics_pdf) $(graphics_png)Bibliography.bib
	pdflatex main.tex
	acroread main.pdf
	touch quickview

.PHONY: clear clean

clear:
	rm -f main.aux main.out main.log main.toc main.lof main.lot main.dvi main.blg main.bbl main.pdf main.bcf main.run.xml main-blx.bib main.mtc* *.log

clean: clear
	rm -f main.pdf
