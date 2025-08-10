make clean

########

if [ 1 == 1 ]; then
# | sed -e "s#url = {#howpublished = {#g"  \

cat bibtex/bib/bibtex_mendeley/Dthesis.bib ./bibtex/bib/oneLepton_official.bib ./bibtex/bib/theory.bib \
 | sed -e "s#W+-#\$W^{\\\pm}\$#g"  \
 | sed -e "s#charginolowdm{\\\_}pub.html#charginolowdm_pub.html#g"  \
 | sed -e "s#(fb-1)#fb\$^{-1}\$#g"  \
 | sed -e "s#(gamma)#\$\\\gamma\$#g"  \
 | sed -e "s#(tau)#\$\\\tau\$#g"  \
 | sed -e "s#(mu)#\$\\\mu\$#g"  \
 | sed -e "s#(rightarrow)#\$\\\rightarrow\$#g"  \
 | sed -e "s#(ttbar)#\$t\\\bar{t}\$#g"  \
 | sed -e "s#(anti-kt)#anti-\$k_t\$#g"  \
 | sed -e "s#(Emiss)1#\E_{T}^{miss}}\$#g"  \
 | sed -e "s#sqrt(s)=7#\$\\\sqrt{s}=7\$#g"  \
 | sed -e "s#sqrt(s)=8#\$\\\sqrt{s}=8\$#g"  \
 | sed -e "s#sqrt(s)=13#\$\\\sqrt{s}=13\$#g"  \
 | sed -e "s#sqrt(s)=14#\$\\\sqrt{s}=14\$#g"  \
 | sed -e "s#Technical report, ##g"  \
 | sed -e "s#mendeley-tags#reportNumber#g"  \
> dthesis.bib
fi
##########

#rm -f dthesis.pdf
#rm -f dthesis.bbl

make
open dthesis.pdf
