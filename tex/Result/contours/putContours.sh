printContours(){
    gridName=$1

    echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    echo "\\clearpage"
    echo "\\subsection{${gridName}} \\label{ sec::Result::exclLimit::${gridName}  }"
    echo "\\begin{figure}[h]"
    echo "  \\centering"
    
    ncont=`(cd ../../../; ls figures/Result/exclContour/*${gridName}*.pdf | wc -l)`
    width=0.98
    if [ `echo ${ncont} | grep -w 4` ]; then
	width=0.48
    elif [ `echo ${ncont} | grep -w 3` ]; then
	width=0.48
    elif [ `echo ${ncont} | grep -w 2` ]; then
	width=0.65
    fi


    cap=""
    for file in `(cd ../../../; ls figures/Result/exclContour/*${gridName}*x12*)`; do
	echo "    \\subfigure[]{\\includegraphics[width=${width}\\textwidth]{${file}}}"
	if [ ! `cat directModels.list | grep ${gridName}` ]; then
	    cap="(a) \$x\$=1/2"
	fi
    done
    
    for file in `(cd ../../../; ls figures/Result/exclContour/*${gridName}*varx*)`; do
	echo "    \\subfigure[]{\\includegraphics[width=${width}\\textwidth]{${file}}}"
	cap="${cap}, (b) $\\mLSP=60\\gev$"
    done
    
    for file in `(cd ../../../; ls figures/Result/exclContour/*${gridName}*dM20*)`; do
	echo "    \\subfigure[]{\\includegraphics[width=${width}\\textwidth]{${file}}}"
	cap="${cap}, (c) $\\dmc=20\\gev$"
    done
    
    for file in `(cd ../../../; ls figures/Result/exclContour/*${gridName}*dM30*)`; do
	echo "    \\subfigure[]{\\includegraphics[width=${width}\\textwidth]{${file}}}"
	cap="${cap}, (d) $\\dmc=30\\gev$"
    done
    
    if [ `cat directModels.list | grep ${gridName}` ]; then
	echo "    \\caption{Exlusion limit (95$\\%$ CL) on the benchmark model \\textbf{${gridName}}.  \\label{ fig::Result::exclLimit::${gridName} } }"
    else
	echo "    \\caption{Exlusion limit (95$\\%$ CL) on the benchmark model \\textbf{${gridName}} for the grids ${cap}.  \\label{ fig::Result::exclLimit::${gridName} } }"
    fi

    echo "\\end{figure}"    
    echo
    echo
    echo
    echo
}

out=../exclLimit_nonBenchMark.tex

echo "\\subsection{Observed Constraints on All Benchmark Models} \\label{ sec::Result::exclLimit::nonBenchMark }" | tee ${out}
for model in `cat onelepModels_Impl.list`; do
#for model in `cat test.list`; do
    printContours $model | tee -a  ${out}
done
