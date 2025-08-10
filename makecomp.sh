make clean

########
cat bibtex/bib/bibtex_mendeley/Dthesis.bib ./bibtex/bib/oneLepton_official.bib ./bibtex/bib/theory.bib \
 | sed -e "s#url = {#howpublished = {#g"  \
 | sed -e "s#sqrt(s)=7#\$\\\sqrt{s}=7\$#g"  \
 | sed -e "s#sqrt(s)=8#\$\\\sqrt{s}=8\$#g"  \
 | sed -e "s#sqrt(s)=13#\$\\\sqrt{s}=13\$#g"  \
 | sed -e "s#fb−#fb\${^{-1}}\$#g"  \
 | sed -e "s#Technical report, ##g"  \
 | sed -e "s#mendeley-tags#reportNumber#g"  \
> dthesis.bib

##########

#rm -f dthesis.pdf
#rm -f dthesis.bbl

make
open dthesis.pdf
