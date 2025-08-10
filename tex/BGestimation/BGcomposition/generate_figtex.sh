generate(){

    regionTag=${1}
    bjetTag=${2}

    outfile=figs_${regionTag}${bjetTag}.tex
    regionName=${regionTag}${bjetTag}

    CRName=CR${regionName}
    if [ "${bjetTag}" == "BT" ]; then
	CRName=TR${regionName}
    elif [ "${bjetTag}" == "BV" ]; then
	CRName=WR${regionName}
    fi

    VRaName=VR${regionName}mt
    if [ "${regionTag}" == "4Jlowx" ]; then
	VRaName=VR${regionName}hybrid
    fi

    VRbName=VR${regionName}apl
    if [ "${regionTag}" == "2J" ]; then
	VRbName=VR${regionName}met
    fi

    VRcName=VR${regionName}hybrid


    echo "\input{tex/BGcomposition/${outfile}}"
 
   if [ "${regionTag}" == "4Jhighx" ]; then
	sed -e "s#REGIONNAME#${regionName}#g; s#CRNAME#${CRName}#g; s#VRANAME#${VRaName}#g; s#VRBNAME#${VRbName}#g; s#VRCNAME#${VRcName}#g" template_4Jhighx.tex > ${outfile}
    else
	sed -e "s#REGIONNAME#${regionName}#g; s#CRNAME#${CRName}#g; s#VRANAME#${VRaName}#g; s#VRBNAME#${VRbName}#g" template.tex > ${outfile}
    fi
}

for regionTag in 2J 4Jlowx 4Jhighx 6J; do 
    for bjetTag in BT BV; do 
	generate  ${regionTag} ${bjetTag}
#	exit
    done
done




