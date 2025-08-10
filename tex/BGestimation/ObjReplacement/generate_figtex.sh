generate(){

    method=${1}
    flavTag=${2}
    treeTag=${3}

    methodName=""   
    if [ "${method}" == "MisLep" ]; then
	methodName="missing lepton replacement"   
    elif [ "${method}" == "TauRep" ]; then
	methodName="tau replacement"   
    elif [ "${method}" == "All" ]; then
	methodName="combined estimation of missing lepton rep. and tau rep."   
    else
	echo "method ${method} is invalid. Abort."; exit
    fi

    flavComment=""
    if [ "${flavTag}" == "el" ]; then
	flavComment="Only electrons in the seed events are replaced"
    elif [ "${flavTag}" == "mu" ]; then
	flavComment="Only muon in the seed events are replaced"
    elif [ "${flavTag}" == "emu" ]; then
	flavComment="Both electrons and muons in the seed events are replaced"
    else
	echo "flavTag ${flavTag} is invalid. Abort."; exit
    fi

    cutComment=""
    if [ "${treeTag}" == "" ]; then
	cutComment="Seed events are collected by the single-lepton trigger. \$p_T>35\\\gev$ for the leading lepton is required"
    elif [ "${treeTag}" == "_softLep" ]; then
	cutComment="Seed events are collected by the use of MET trigger. \$p_T<35\\\gev$ for the leading lepton is required"
    else
	echo "treeTag ${treeTag} is invalid. Abort."; exit
    fi


    outfile=figs_mcClosure_${method}${treeTag}_${flavTag}.tex
    echo ${outfile}
    sed -e "s#METHODTAG#${method}#g; s#METHODNAME#${methodName}#g; s#_TREENAME#${treeTag}#g; s#FLAVTAG#${flavTag}#g; s#FLAVCOMMENT#${flavComment}#g; s#CUTCOMMENT#${cutComment}#g" closureFig_template.tex > ${outfile}



}

for method in All MisLep TauRep; do 
    for flavTag in el mu emu; do 
	for treeTag in "" "_softLep"; do 
	    generate  ${method} ${flavTag} ${treeTag}
	done
    done
done




