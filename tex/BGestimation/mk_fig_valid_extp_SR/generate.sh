generate(){
    regName=$1
    regLabel=$2

    echo "\begin{figure}[h]"
    echo "  \centering"
    echo "    \subfigure[]{\includegraphics[width=0.48\textwidth]{figures/BGestimation/valid_extp/SFTF_wjets_SR${regName}_extp_var2J__nJet30.pdf.pdf}}"
    echo "    \subfigure[]{\includegraphics[width=0.48\textwidth]{figures/BGestimation/valid_extp/SFTF_ttNoObjRep_SR${regName}_extp_var2J__ttPt.pdf.pdf}}"
    echo "    \subfigure[]{\includegraphics[width=0.48\textwidth]{figures/BGestimation/valid_extp/.pdf}}"
    echo ""
    echo "    \caption{Non-closure of kinematical extrapolation in SR/CR ${regLabel}. Top rows in the plots show the yield variation of (a) $\wjets$ when one injects mis-modeling of $y_{\ttbar} = 1.0 - x \times \nJet-2)$, and (b) $\ttbar$ with the mis-modeling of $1 - w \times \pt(\ttbar) / 100\gev$. The variation in the control region corresponds to the normalization factor obtained via the CR fit, which is ideally equal to that in the signal region. Bottom plots are the relative difference in their response against the injected mis-modeling, namely the resultant . All evaluated by MC. For the $\ttbar$ process, component estimated by the object replacement method is removed.  \label{fig::BGestimation::valid_extp_${regName}} }"
    echo "\end{figure}"
}
generate 2JMEFF1 "2J $\meffInc$ bin-1"
#generate 2JMEFF2 "2J $\meffInc$ bin-2"
#generate 2JMEFF3 "2J $\meffInc$ bin-3"

#generate 6JMEFF1 "6J $\meffInc$ bin-1"
#generate 6JMEFF2 "6J $\meffInc$ bin-2"
#generate 6JMEFF3 "6J $\meffInc$ bin-3"

#generate 3BMEFF1 "3B $\meffInc$ bin-1"
#generate 3BMEFF2 "3B $\meffInc$ bin-2"

