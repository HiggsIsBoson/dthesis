LATEX    = latex
BIBTEX   = bibtex
DVIPS    = dvips

BASENAME = dthesis
vref=20170731

default: pdflatex
#default: test


test:
	pdflatex  ${BASENAME}

pdflatex:
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}
	bibtex    ${BASENAME}
#	cat dthesis.bbl bibtex/bib/theory.bbl > log; mv log dthesis.bbl 
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}

latex:
	latex  ${BASENAME}
	latex  ${BASENAME}
	bibtex ${BASENAME}
	latex  ${BASENAME}
	latex  ${BASENAME}
	dvipdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress ${BASENAME}

diff:
	@echo "reference: $(vref)"
	@latexdiff ../DoctoralThesis_backup_20170731/$(BASENAME).tex $(BASENAME).tex | tee diff_$(vref)_current.tex
	ls -l diff_$(vref)_current.tex 
	pdflatex diff_$(vref)_current.tex 


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

