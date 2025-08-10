inFilePath="/Users/cshionjp/Desktop/Lab/ATLAS/studies/strong1L/myAnaResult/tag-01-04/theorySyst/output/BG_v2/summary_theoSyst_BG.txt"
echo inFilePath ${inFilePath}

getProcLabel(){
    proc=${1}
    echo ${proc} | sed -e "s#Wjets#\$\\\wjets\$#g; s#Zjets#\$\\\zjets\$#g; s#ttbar#\$\\\ttbar+Wt\$#g; s#VV#Di-boson#g; s#ttV#\$\\\ttbar+V\$#g"
}

getRegionLabel(){
    reg=${1}
    echo ${reg} | sed -e "s#SR#SR #g" | sed -e "s#VRa#VRa #g" | sed -e "s#VRb#VRb #g" | sed -e "s#MEFF1# \$\\\meffIncFirst\$#g"  | sed -e "s#MEFF2# \$\\\meffIncSecond\$#g"  | sed -e "s#MEFF3# \$\\\meffIncThird\$#g"  | sed -e "s#Lowx#Low-x#g"  | sed -e "s#Highx#High-x#g" 
}

getTitle(){
    proc=$1
    title=`cat ${inFilePath} | grep ${proc} | grep SRLowx | cut -d " " -f 3  | junction_lines`
    echo ${title} | sed -e " \
	s#scale#QCD_scale#g; \
	s#genSherpa#Hard_processes#g; \
	s#had#Parton_shower#g; \
	s#ckkw#Matching_scale#g; \
	s#fac#Factorization_scale#g; \
	s#renorm#Renormalization_scale#g; \
	s#intf_WWbb#tt+Wtb_vs_ WWbb#g; \
	s#_FS##g; \
	s#qsf#QCD_scale#g \
"

}
getErr(){
    proc=$1
    region=$2

    err=""
    for sub in `cat ${inFilePath} | grep ${proc} | grep ${region} | cut -d " " -f 4`; do
	if [ `echo ${sub} | grep "0.0" | tr -d " "` ]; then
	    err=${err}"|-"
	else
	    err=${err}"|"${sub}
	fi
    done
    echo $err | sed -e "s#^|##g"
}

genTab_CR(){
    proc=$1
    
    title="      &  "`getTitle ${proc} | sed -e "s#|#\  \&\  #g; s#_#\ #g"`"  \\\\"
    ncol=`echo "${title}" | sed -e 's@[^&]@@g' `
    echo 
    
    header="\tab{ "
    for i in `seq 0 ${#ncol}`; do
	header="${header}c "
	if [ "${i}" == 0 ]; then header="${header}| "; fi
    done
    header="${header}}{"

    echo ${header}
    echo "\\hline"
    echo ${title}
    echo "\\hline"
    echo "\\hline"

    for reg in SR2J  SR6J  SRLowx  SRHighx  SR3B  "hline" VRa2J  VRa6J  VRaLowx  VRaHighx  VRa3B   "hline" VRb2J  VRb6J  VRbLowx  VRbHighx  VRb3B  ; do
	if [ `echo ${reg} | grep hline` ]; then
	    echo "\\hline"
	else
	    echo "    " `getRegionLabel ${reg}` " & " `getErr ${proc} ${reg} | sed -e "s#|#\  \&\  #g; s#MEFFIncl##g"` "\\\\"
	fi
    done


    echo "\\hline"
    echo "}"

    procLabel=`getProcLabel ${proc}`
    echo "{Theory systematics assigned for the post-fit yields for ${procLabel} [\$\\%\$]. The numbers are shared by all the \$\\meffInc\$-bins in the same SR/VR tower. Systematics contributing below 5\$\\%\$ or 5 times less than that of the leading uncertainty in the region are ignored (labeled as \"-\"). }"
    echo "{tab::Uncertainties::theoSys_${proc}}"
    echo
}



genTab_noCR(){
    proc=$1
    
    title="      &  "`getTitle ${proc} ${reg} | junction_lines | sed -e "s#|#\  \&\  #g; s#_#\ #g"`"  \\\\"
    ncol=`echo "${title}" | sed -e 's@[^&]@@g' `
    echo 
    
    header="\tab{ "
    for i in `seq 0 ${#ncol}`; do
	header="${header}c "
    done
    header="${header}}{"

    echo ${header}
    echo "\\hline"
    echo "\\hline"
    echo ${title}
    echo "\\hline"
    for reg in 2JMEFF1 2JMEFF2 2JMEFF3  6JMEFF1 6JMEFF2 6JMEFF3  Lowx  Highx  3BMEFF1 3BMEFF2    ; do
	echo "    " `getRegionLabel ${reg}` " & " `getErr ${proc} ${reg} | sed -e "s#|#\  \&\  #g; s#MEFFIncl##g"` "\\\\"
    done
    echo "\\hline"
    echo "}"
    
    procLabel=`getProcLabel ${proc}`
    echo "{Theory systematics assigned for the yields of ${procLabel} [\$\\%\$]. The uncertainty is shared by SRs and corresponding VRs. Systematics contributing below 5\$\\%\$ or 5 times less than that of the leading uncertainty in the region are ignored (labeled as \"-\"). }"
    echo "{tab::Uncertainties::theoSys_${proc}}"
    echo
}

if [ 1 == 1 ] ; then
out="../theoSyst.tex"
rm -f ${out}

genTab_CR Wjets | tee -a ${out}
genTab_CR ttbar | tee -a ${out}

genTab_noCR Zjets | tee -a ${out}
#genTab_noCR Wt | tee -a ${out}
genTab_noCR VV | tee -a ${out}
genTab_noCR ttV | tee -a ${out}
fi
