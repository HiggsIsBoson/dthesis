LATEX    = latex
BIBTEX   = bibtex
DVIPS    = dvips

#BASENAME = summary
BASENAME = Abstract

#default: testpdflatex
default: testlatex


test:
	pdflatex  ${BASENAME}

testpdflatex:
	platex  ${BASENAME}
	platex  ${BASENAME}

testlatex:
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}
	bibtex ${BASENAME}
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}
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

