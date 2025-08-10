for dir in `ls | grep -v .sh | grep -v backup| grep -v "~"`; do
    cp ${dir}/*  ./backup/${dir}
    rename -s .tex .txt ./backup/${dir}/*
    cp ${dir}/*  ./backup/${dir}
done
