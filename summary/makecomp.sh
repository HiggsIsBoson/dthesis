make clean

########
rm -f summary.pdf
rm -f summary.bbl

make
open summary.pdf
