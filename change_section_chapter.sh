for file in `ls tex/*/*.tex`; do 
#    sed -i -e "s#\\subsubsection#\\subsection#g; s#\\subsection#\\section#g; s#\\section{#\\chapter{#g"  ${file}
    sed -i -e "s#\\chapter#\\section#g"  ${file}
#    break
done

