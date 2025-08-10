LATEX    = latex
BIBTEX   = bibtex
DVIPS    = dvips

BASENAME = dthesis

default: testpdflatex
#default: test


test:
	pdflatex  ${BASENAME}

testpdflatex:
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}
	bibtex    ${BASENAME}
#	cat dthesis.bbl bibtex/bib/theory.bbl > log; mv log dthesis.bbl 
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}

testlatex:
	latex  ${BASENAME}
	latex  ${BASENAME}
	bibtex ${BASENAME}
	latex  ${BASENAME}
	latex  ${BASENAME}
	dvipdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress ${BASENAME}


#
# standard Latex targets
#

%.dvi:	%.tex 
	$(LATEX) $<

%.bbl:	%.tex *.bib
	$(LATEX) $*
	$(BIBTEX) $*

%.ps:	%.dvi
	$(DVIPS) $< -o $@

%.pdf:	%.tex
	$(PDFLATEX) $<

.PHONY: clean

clean:
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg  \
	      *.inx *.dvi *.toc *.out *~ ~* spellTmp 

