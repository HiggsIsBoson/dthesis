#baseDir=/Users/cshionjp/Desktop/Lab/ATLAS/studies/strong1L/myAnaResult/tag-01-02/fitResult/myAna_objRep_shapeSys/
#baseDir=/Users/cshionjp/Desktop/Lab/ATLAS/studies/strong1L/myAnaResult/tag-01-04/fitResult/bkgOnly/tables-01-04_v1/myAna_objRep_shapeSys/
baseDir=/Users/cshionjp/Desktop/Lab/ATLAS/studies/strong1L/myAnaResult/tag-01-04/fitResult/bkgOnly/tag-01-04_v2/myAna_tag858_objRep_shapeSys/output/
baseName=${baseDir}myAna_tag858_objRep_shapeSys

dump(){
    inFilePath=${1}
    outFilePath=${2}

    ## obs.
    cat ${inFilePath} | grep Observed | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    
    ## post-fit
    echo "\\midrule"  | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted bkg events" | sed -e "s#Fitted bkg#MC total (post-fit)#g"     | cut -d "&" -f 1,3- | tee -a ${outFilePath}  
    echo "\\midrule"  | tee -a ${outFilePath}
 
    cat ${inFilePath} | grep "Fitted Wjets"     | sed -e "s#Fitted Wjets#\$W$+jets#g"              | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted zjets"     | sed -e "s#Fitted zjets\\\_Sherpa22#\$Z\$+jets#g" | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted ttbar"     | sed -e "s#Fitted ttbar#\$t\\\bar{t}\$#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted singletop" | sed -e "s#Fitted singletop#Single-top#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted diboson"   | sed -e "s#Fitted diboson#Di-boson#g"             | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "Fitted ttv"       | sed -e "s#Fitted ttv#\$t\\\bar{t}+V\$#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}

    ## pre-fit
    echo "\\midrule"  | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. SM events" | sed -e "s#MC exp. SM#MC total (pre-fit)#g"     | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
 
    cat ${inFilePath} | grep "MC exp. Wjets"     | sed -e "s#MC exp. Wjets#\$W$+jets#g"              | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. zjets"     | sed -e "s#MC exp. zjets\\\_Sherpa22#\$Z\$+jets#g" | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. ttbar"     | sed -e "s#MC exp. ttbar#\$t\\\bar{t}\$#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. singletop" | sed -e "s#MC exp. singletop#Single-top#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. diboson"   | sed -e "s#MC exp. diboson#Di-boson#g"             | cut -d "&" -f 1,3- | tee -a ${outFilePath}
    cat ${inFilePath} | grep "MC exp. ttv"       | sed -e "s#MC exp. ttv#\$t\\\bar{t}+V\$#g"         | cut -d "&" -f 1,3- | tee -a ${outFilePath}
}


dump2_Impl(){

    in1=$1
    in2=$2
    key="${3}"
    echo `cat ${in1} | grep "${key}"            | cut -d "&" -f 1,3 | cut -d "$" -f 1-2`"$ & "`cat ${in2} | grep "${key}"            | cut -d "&" -f 3-`

}

dump2(){
    inFilePath1=${1}
    inFilePath2=${2}
    outFilePath=${3}

    echo `dump2_Impl ${inFilePath1} ${inFilePath2} Observed`  | tee -a ${outFilePath}

    ##### post-fit
    echo "\\midrule"  | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted bkg events"`  | sed -e "s#Fitted bkg#MC total (post-fit)#g"    | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted Wjets"    ` | sed -e "s#Fitted Wjets#\$W$+jets#g"              | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted zjets"    ` | sed -e "s#Fitted zjets\\\_Sherpa22#\$Z\$+jets#g" | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted ttbar"    ` | sed -e "s#Fitted ttbar#\$t\\\bar{t}\$#g"         | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted singletop"` | sed -e "s#Fitted singletop#Single-top#g"         | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted diboson"  ` | sed -e "s#Fitted diboson#Di-boson#g"             | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "Fitted ttv"      ` | sed -e "s#Fitted ttv#\$t\\\bar{t}+V\$#g"         | tee -a ${outFilePath}

    ##### pre-fit
    echo "\\midrule"  | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. SM events"`  | sed -e "s#MC exp. SM#MC total (pre-fit)#g"    | tee -a ${outFilePath}
    echo "\\midrule"  | tee -a ${outFilePath}
    
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. Wjets"    ` | sed -e "s#MC exp. Wjets#\$W$+jets#g"              | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. zjets"    ` | sed -e "s#MC exp. zjets\\\_Sherpa22#\$Z\$+jets#g" | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. ttbar"    ` | sed -e "s#MC exp. ttbar#\$t\\\bar{t}\$#g"         | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. singletop"` | sed -e "s#MC exp. singletop#Single-top#g"         | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. diboson"  ` | sed -e "s#MC exp. diboson#Di-boson#g"             | tee -a ${outFilePath}
    echo `dump2_Impl ${inFilePath1} ${inFilePath2} "MC exp. ttv"      ` | sed -e "s#MC exp. ttv#\$t\\\bar{t}+V\$#g"         | tee -a ${outFilePath}


}

dump2J(){
    outTex=yieldTable_2J.tex
    rm -f ${outTex}

    cat yieldTable_template_2J_1.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_WR2J.tex ${outTex}
    cat yieldTable_template_mid.tex | tee -a ${outTex}
    
    cat yieldTable_template_2J_2.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_TR2J.tex ${outTex}    
    cat yieldTable_template_end.tex | tee -a ${outTex}
    
    sed -i -e "s#\ events##g; s#Observed#Observed\ data#g" ${outTex}
}




dump6J(){
    outTex=yieldTable_6J.tex
    rm -f ${outTex}

    cat yieldTable_template_6J_1.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_WR6J.tex ${outTex}
    cat yieldTable_template_mid.tex | tee -a ${outTex}    

    cat yieldTable_template_6J_2.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_TR6J.tex ${outTex}
    
    cat yieldTable_template_end.tex | tee -a ${outTex}
    
    sed -i -e "s#\ events##g; s#Observed#Observed\ data#g" ${outTex}
}

dump3B(){
    outTex=yieldTable_3B.tex
    rm -f ${outTex}

    cat yieldTable_template_3B_1.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_WR3B.tex ${outTex}
    cat yieldTable_template_mid.tex | tee -a ${outTex}
    
    cat yieldTable_template_3B_2.tex | cut -d "&" -f 1,3- | tee -a ${outTex}
    dump ${baseName}_TR3B.tex ${outTex}    
    cat yieldTable_template_end.tex | tee -a ${outTex}
    
    sed -i -e "s#\ events##g; s#Observed#Observed\ data#g" ${outTex}
}

dumpLowx(){
    outTex=yieldTable_Lowx.tex
    rm -f ${outTex}

    cat yieldTable_template_Lowx.tex | cut -d "&" -f 1- | tee -a ${outTex}
    dump2 ${baseName}_WRLowx.tex ${baseName}_TRLowx.tex ${outTex} 
    cat yieldTable_template_end.tex | tee -a ${outTex}    

    sed -i -e "s#\ events##g; s#Observed#Observed\ data#g" ${outTex}

}

dumpHighx(){
    outTex=yieldTable_Highx.tex
    rm -f ${outTex}

    cat yieldTable_template_Highx.tex | cut -d "&" -f 1- | tee -a ${outTex}
    dump2 ${baseName}_WRHighx.tex ${baseName}_TRHighx.tex ${outTex} 
    cat yieldTable_template_end.tex | tee -a ${outTex}    

    sed -i -e "s#\ events##g; s#Observed#Observed\ data#g" ${outTex}
}



dump2J
dump6J
dumpLowx
dumpHighx
dump3B
rm -f *-e

cat yieldTable_caption.tex yieldTable_[2,6]J.tex yieldTable_Lowx.tex yieldTable_Highx.tex yieldTable_3B.tex > ../tab_CRyields.tex
