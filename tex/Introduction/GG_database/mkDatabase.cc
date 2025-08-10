#include "/Users/cshionjp/Desktop/Lab/ATLAS/studies/FuncClass/myGGinfo/GGHandler.h"

using namespace std;
using namespace GGHandler;

const float BR_TAU_1L = 0.35;
const float BR_W_1L = 0.25;
const float BR_Z_1L = 0.01365; // tautau->taultauh
const float BR_Z_2L = 0.0775; // including tautau->taultaul

const float BR_T_1B = 0.987;

struct GGdata {
  float brL[5]; 
  float brB[3];
  float meanL;
  float meanJ;
  float meanB;
};

GGdata getDecayData(TString decay){

  GGdata data;

  if(decay=="QQ"){
    data.brL[0] = 1.;    data.brL[1] = 0.;    data.brL[2] = 0.;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 1.;    data.brB[1] = 0.;    data.brB[2] = 0.;
    data.meanJ=2;
  }
  else if(decay=="BB"){
    data.brL[0] = 1.;    data.brL[1] = 0.;    data.brL[2] = 0.;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 0.;    data.brB[1] = 0.;    data.brB[2] = 1.;
    data.meanJ=2;
  }

  else if(decay=="N1"){
    data.brL[0] = 1.;    data.brL[1] = 0.;    data.brL[2] = 0.;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 1.;    data.brB[1] = 0.;    data.brB[2] = 0.;
    data.meanJ=0;
  }

  else if(decay=="BT"){
    data.brL[0] = 1.-BR_W_1L;    data.brL[1] = BR_W_1L;    data.brL[2] = 0.;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 0.;    data.brB[1] = 1.-BR_T_1B;    data.brB[2] = BR_T_1B;
    data.meanJ= 4*data.brL[0] + 2*data.brL[1];
  }
  else if(decay=="C1"){
    data.brL[0] = 1.-BR_W_1L;    data.brL[1] = BR_W_1L;    data.brL[2] = 0.;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 1.;            data.brB[1] = 0.;         data.brB[2] = 0.;
    data.meanJ= 2*data.brL[0] + 0*data.brL[1];
  }
  else if(decay=="TT"){
    data.brL[0] = pow(1.-BR_W_1L,2);    data.brL[1] = 2*BR_W_1L*(1.-BR_W_1L);    data.brL[2] = BR_W_1L*BR_W_1L;   data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = pow(1.-BR_T_1B,2);    data.brB[1] = 2*BR_T_1B*(1.-BR_T_1B);    data.brB[2] = BR_T_1B*BR_T_1B;

    data.meanJ= 6*data.brL[0] + 4*data.brL[1] + 2*data.brL[2];
  }

  else if(decay=="N2Z"){
    data.brL[0] = 1.-BR_Z_1L-BR_Z_2L;    data.brL[1] = BR_Z_1L;    data.brL[2] = BR_Z_2L;    data.brL[3] = 0.;    data.brL[4] = 0.;
    data.brB[0] = 0.85;    data.brB[1] = 0.;    data.brB[2] = 0.15;
    data.meanJ= 2*data.brL[0] + 1*data.brL[1] + 0*data.brL[2];
  }
  else if(decay=="N2H"){
    float H_BB=0.57;
    float H_WW_allHad = 0.21*pow(1-BR_W_1L,2) ;
    float H_ZZ_allHad = 0.03*pow(1-BR_Z_1L-BR_Z_2L,2);
    float H_TAUTAU_allHad = 0.06*pow(1-BR_TAU_1L,2) ;

    float H_WW_semiLep = 0.21*2*BR_W_1L*(1-BR_W_1L) ;
    float H_ZZ_semiLep = 0.03*2*BR_Z_1L*(1-BR_Z_1L-BR_Z_2L);
    float H_TAUTAU_semiLep = 0.06 * 2*BR_TAU_1L*(1-BR_TAU_1L);

    float H_WW_diLep = 0.21*pow(BR_W_1L,2) ;
    float H_ZZ_diLep = 0.03 * 2*BR_Z_2L*(1-BR_Z_1L-BR_Z_2L) * pow(BR_Z_1L,2);
    float H_TAUTAU_diLep = 0.06*pow(BR_TAU_1L,2) ;

    data.brL[0] = 
      H_BB + H_WW_allHad + H_ZZ_allHad + H_TAUTAU_allHad
      + 0.13; // bb, WW/ZZ/tautau (allhad) + gg/cc/others(13%) 

    data.brL[1] = H_WW_semiLep + H_ZZ_semiLep + H_TAUTAU_semiLep;  // WW/ZZ/tautau -> 1L    

    data.brL[2] = H_WW_diLep  +  H_ZZ_diLep +  H_TAUTAU_diLep;      // WW/ZZ/tautau -> 1L    

    data.brL[3] = 2*BR_Z_1L*BR_Z_2L;    // ZZ -> 3L
    data.brL[4] = pow(BR_Z_2L,2);       // ZZ -> 4L

    data.brB[0] = 1.-H_BB;    data.brB[1] = 0.;    data.brB[2] = H_BB;

    data.meanJ= 4 * (H_WW_allHad+H_ZZ_allHad) + 2*(H_BB+H_WW_semiLep+H_ZZ_semiLep+H_TAUTAU_allHad);
  }
  else{
    cout << "Unknown decay: " << decay << ". Abort. " << endl;
    abort();
  }  

  data.meanL=0;  for(int il=0; il<=4; ++il)  data.meanL += il*data.brL[il];
  data.meanB=0;  for(int ib=0; ib<=2; ++ib)  data.meanB += ib*data.brB[ib];

  return data;

}



void mkDatabase_Impl(TString gridName="BTC1TTN1"){

  TString sq1, schi1, sq2, schi2;  get_decayMode(gridName, sq1, schi1, sq2, schi2);
  
  GGdata data_q1   = getDecayData(sq1);
  GGdata data_q2   = getDecayData(sq2);
  GGdata data_chi1 = getDecayData(schi1);
  GGdata data_chi2 = getDecayData(schi2);

  float b_0L = data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[0] ;
  float b_1L = 
    data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[1] ;

  float b_2L = 
    data_q1.brL[1]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[0] 
    +data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[1] 
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[1]*data_chi2.brL[0]
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[1]
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[1] 

    +data_q1.brL[2]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[2]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[2]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[2] ;

  float b_3L = 
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[1]*data_chi2.brL[1] 
    +data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[1] 
    +data_q1.brL[1]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[1] 
    +data_q1.brL[1]*data_q2.brL[1]*data_chi1.brL[1]*data_chi2.brL[0] 

    +data_q1.brL[1]*data_q2.brL[2]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[2]*data_chi2.brL[0] 
    +data_q1.brL[1]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[2] 
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[2]*data_chi2.brL[0]
    +data_q1.brL[0]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[2]
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[2] 

    +data_q1.brL[2]*data_q2.brL[1]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[2]*data_q2.brL[0]*data_chi1.brL[1]*data_chi2.brL[0] 
    +data_q1.brL[2]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[1] 
    +data_q1.brL[0]*data_q2.brL[2]*data_chi1.brL[1]*data_chi2.brL[0]
    +data_q1.brL[0]*data_q2.brL[2]*data_chi1.brL[0]*data_chi2.brL[1]
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[2]*data_chi2.brL[1] 

    +data_q1.brL[3]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[3]*data_chi1.brL[0]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[3]*data_chi2.brL[0] 
    +data_q1.brL[0]*data_q2.brL[0]*data_chi1.brL[0]*data_chi2.brL[3] ;

  //--------------------
  float tr_b_0B = data_q1.brB[0]*data_q2.brB[0]*data_chi1.brB[0]*data_chi2.brB[0] ;
  float tr_b_2B = 
    data_q1.brB[2]*data_q2.brB[0]*data_chi1.brB[0]*data_chi2.brB[0] 
    +data_q1.brB[0]*data_q2.brB[2]*data_chi1.brB[0]*data_chi2.brB[0] 
    +data_q1.brB[0]*data_q2.brB[0]*data_chi1.brB[2]*data_chi2.brB[0] 
    +data_q1.brB[0]*data_q2.brB[0]*data_chi1.brB[0]*data_chi2.brB[2] ;
  float tr_b_4B = 
    data_q1.brB[2]*data_q2.brB[2]*data_chi1.brB[0]*data_chi2.brB[0] 
    +data_q1.brB[2]*data_q2.brB[0]*data_chi1.brB[2]*data_chi2.brB[0] 
    +data_q1.brB[2]*data_q2.brB[0]*data_chi1.brB[0]*data_chi2.brB[2] 
    +data_q1.brB[0]*data_q2.brB[2]*data_chi1.brB[2]*data_chi2.brB[0]
    +data_q1.brB[0]*data_q2.brB[2]*data_chi1.brB[0]*data_chi2.brB[2]
    +data_q1.brB[0]*data_q2.brB[0]*data_chi1.brB[2]*data_chi2.brB[2] ;

  float tr_b_6B = 
    data_q1.brB[0]*data_q2.brB[2]*data_chi1.brB[2]*data_chi2.brB[2] 
    +data_q1.brB[2]*data_q2.brB[0]*data_chi1.brB[2]*data_chi2.brB[2] 
    +data_q1.brB[2]*data_q2.brB[2]*data_chi1.brB[0]*data_chi2.brB[2] 
    +data_q1.brB[2]*data_q2.brB[2]*data_chi1.brB[2]*data_chi2.brB[0] ;


  float meanL = data_q1.meanL + data_q2.meanL + data_chi1.meanL + data_chi2.meanL;
  float meanB = data_q1.meanB + data_q2.meanB + data_chi1.meanB + data_chi2.meanB;
  float meanJ = data_q1.meanJ + data_q2.meanJ + data_chi1.meanJ + data_chi2.meanJ;


  const float eB = 0.77;
  float b_0B      = tr_b_0B + tr_b_2B*pow(1-eB,2);
  float b_1B_2B   = tr_b_2B*(1-pow(1-eB,2)) + tr_b_4B*(6*pow(1-eB,2)*pow(eB,2)+4*pow(1-eB,3)*pow(eB,1)+pow(1-eB,4));
  float b_3B_plus = tr_b_4B * ( 4*pow(1-eB,1)*pow(eB,3) + pow(eB,4) ) + tr_b_6B*(30*pow(1-eB,3)*pow(eB,3)+15*pow(1-eB,2)*pow(eB,4)+6*pow(1-eB,1)*pow(eB,5)+pow(eB,6));
  float b_4B_plus = tr_b_4B*pow(eB,4) + tr_b_6B*(15*pow(1-eB,2)*pow(eB,4)+6*pow(1-eB,1)*pow(eB,5)+pow(eB,6)) ;

  //cout << "L: " << setw(10) << gridName << " " << setw(6) << b_0L << " " << setw(6) << b_1L << " " << setw(6) << b_2L << " " << setw(6) << 1-b_0L-b_1L-b_2L << endl;
  //cout << "B: " << setw(10) << "  " << setw(6) << b_0B << " " << setw(6) << b_1B_2B << " " << setw(6) << b_3B_plus << " " << setw(6) << b_4B_plus << endl;


  TString s12 = b_2L==0 ? "-" : b_1L/b_2L>1. ? ftoa(b_1L/b_2L,3) : ftoa(b_1L/b_2L,2);
  TString s10 = b_0L==0 ? "-" : b_1L/b_0L>1. ? ftoa(b_1L/b_0L,3) : ftoa(b_1L/b_0L,2);
  TString sJ  = meanJ>10 ? ftoa(meanJ,3) : ftoa(meanJ,2);

  if(gridName.Contains("TTN1TTN1") || gridName.Contains("QQC1QQC1")  || gridName.Contains("QQC1BTC1"))
    cout << "  \\textcolor{red}{\\textbf{" << gridName << "}} & " << ftoa(meanJ,2) << " & " << ftoa(meanB,2) << " & " << s10 << " & " << s12;
  else
    cout << "  " << gridName << " & " << sJ << " & " << ftoa(meanB,2) << " & " << s10 << " & " << s12 ;

  if(gridName.Contains("TTN1TTN1") || gridName.Contains("QQC1QQC1")  || gridName.Contains("QQC1BTC1") || gridName.Contains("QQC1QQN2Z") || gridName.Contains("QQC1QQN2H"))
    cout << " & \\checkmark   \\\\ \\hline" << endl;
  else
    cout << " & \\\\ \\hline" << endl;

}




void mkDatabase(){

  TString common = "The average jet multiplicity ($n_{\\mathrm{J}}$) and b-jet multiplicity ($n_{\\mathrm{B}}$) are calculated based on number of quarks an b-quarks appearing in the final state. The PDG values \\cite{PDG2016} are referred for branching ratio of top, W/Z/h bosons. $``\\checkmark''$ specifies the models with the final result derived using the full simulated samples, while the others are with emulated truth samples.";

  ////////////////////////////////////////////////////
  cout << "\\tab{c c c c c c}{" << endl;
  cout << "  \\hline" << endl;
  cout << "  \\textbf{1-step decay}  & $n_{\\mathrm{J}}$ &  $n_{\\mathrm{B}}$ & Br(1L)/Br(0L) & Br(1L)/Br(2L)  & full sim.?  \\\\ \\hline" << endl;
  cout << "  \\hline" << endl;
  for(TString model : {"QQN1QQC1","QQC1QQC1", "QQC1QQN2Z","QQC1QQN2H"}) mkDatabase_Impl(model);

  cout << "  \\hline" << endl;
  cout << "}" << endl;
  cout << "{Target models with no b-jets at tree level." << common << "}" << endl;
  cout << "{tab::Introduction::modelsBV}" << endl;
  cout << endl << endl << endl;

  ////////////////////////////////////////////////
  cout << "\\tab{c c c c c c}{" << endl;
  cout << "  \\hline" << endl;
  cout << "  \\textbf{Direct decay}  & $n_{\\mathrm{J}}$ &  $n_{\\mathrm{B}}$ & Br(1L)/Br(0L) & Br(1L)/Br(2L)  & full sim.?  \\\\ \\hline" << endl;
  cout << "  \\hline" << endl;
  for(TString model : {"QQN1TTN1"})  mkDatabase_Impl(model);

  cout << "  \\hline" << endl;
  cout << "  \\textbf{1-step decay}  & $n_{\\mathrm{J}}$ &  $n_{\\mathrm{B}}$ & Br(1L)/Br(0L) & Br(1L)/Br(2L)  & full sim.?  \\\\ \\hline" << endl;
  cout << "  \\hline" << endl;
  for(TString model : {"QQN1BTC1","QQN1TTN2Z","QQC1BTC1","QQC1BBN2Z","QQC1TTN2Z","QQN2ZTTN2Z","BBN1QQC1","BTC1QQN2Z","TTN1QQC1","TTN1QQN2Z"})
    mkDatabase_Impl(model);

  cout << "  \\hline" << endl;
  cout << "}" << endl;
  cout << "{Target models with 1 or 2 b-jets at tree level. " << common << "}" << endl;
  cout << "{tab::Introduction::modelsBT}" << endl;
  cout << endl << endl << endl;

  ////////////////////////////////////////////////
  cout << "\\tab{c c c c c c}{" << endl;
  cout << "  \\hline" << endl;
  cout << "  \\textbf{Direct decay}  & $n_{\\mathrm{J}}$ &  $n_{\\mathrm{B}}$ & Br(1L)/Br(0L) & Br(1L)/Br(2L)  & full sim.?  \\\\ \\hline" << endl;
  cout << "  \\hline" << endl;
  for(TString model : {"BBN1TTN1","TTN1TTN1"}) mkDatabase_Impl(model);

  cout << "  \\hline" << endl;
  cout << "  \\textbf{1-step decay}  & $n_{\\mathrm{J}}$ &  $n_{\\mathrm{B}}$ & Br(1L)/Br(0L) & Br(1L)/Br(2L)  & full sim.?  \\\\ \\hline" << endl;
  cout << "  \\hline" << endl;
  for(TString model : {"QQN1TTN2H","QQC1BBN2H","QQC1TTN2H","QQN2ZTTN2H","QQN2HTTN2H","BBN1BTC1","BBN1TTN2Z","BBN1TTN2H","BBN2ZTTN2Z","BBN2ZTTN2H","BBN2HTTN2H","BTC1BTC1","BTC1QQN2H","BTC1BBN2Z","BTC1BBN2H","BTC1TTN2Z","BTC1TTN2H","TTN1QQN2H","TTN1BTC1","TTN1BBN2Z","TTN1BBN2H","TTN1TTN2Z","TTN1TTN2H","TTN2ZQQN2H","TTN2ZBBN2H","TTN2ZTTN2Z","TTN2ZTTN2H","TTN2HTTN2H"})    
    mkDatabase_Impl(model);

  cout << "  \\hline" << endl;
  cout << "}" << endl;
  cout << "{Target models with 3 or more b-jets at tree level." << common << "}" << endl;
  cout << "{tab::Introduction::models3B}" << endl;
  /////////////////////////////////////////////////////
  
    
}
