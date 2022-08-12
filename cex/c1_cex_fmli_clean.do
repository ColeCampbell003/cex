/*

Name: CEX_fmli_clean.do
Author: Shogher Ohannessian
Date: 08/02/2021
Edited by:
Edit date: 
Purpose: Clean the appended CEX fmli dataset.
Source:  
Input: $workdir/CEX/fmli.dta
Output: $workdir/CEX/fmli_clean.dta
Notes: 

- Some years have a 1x file and a 1 file for the first quarter of the following year, right now we are using the equivalent of the 1x files for each year except for 2020. 

***
*** 1. Restrict to 1x files
*** 2. Adjust the variables to inflation
***

*/


use "$workdir/CEX/fmli.dta", clear 


***
*** 1. Restrict to 1x files
***

*Some years have a 1x file and a 1 file for the first quarter of the following year, right now we are using the equivalent of the 1x files for each year except for 2020.
drop if quarter == "1" & year < 2020 
replace quarter = "1" if quarter == "1x"

isid newid quarter year
isid newid qintrvyr qintrvmo


***
*** 2. Adjust the variables to inflation
***
destring _all, replace 

gen yq = yq(year, quarter)
format yq %tq

// merge m:1 yq using "$workdir/inflation_quarterly.dta", keepusing(inflator) keep(master matched) nogen
//
// foreach var in totexpcq foodcq alcbevcq houscq apparcq transcq healthcq entertcq perscacq readcq educacq tobacccq lifinscq misccq cashcocq retpencq etotalc ehousngc etranptc eentrmtc emiscelc perinscq fdhomecq fdawaycq emiscmtc houseqcq housopcq utilcq gasmocq pubtracq othhexcq totexppq foodpq alcbevpq houspq apparpq transpq healthpq entertpq perscapq readpq educapq tobaccpq lifinspq miscpq cashcopq retpenpq etotalp ehousngp etranptp eentrmtp emiscelp perinspq fdhomepq fdawaypq emiscmtp houseqpq housoppq utilpq gasmopq pubtrapq othhexpq fincbtax fincatax fsalaryx fnonfrmx ffrmincx frretirx fssix famtfedx fsltaxx {
// replace `var' = `var'*inflator
// }
// drop inflator

order yq year quarter newid finlwt21 qintrvmo qintrvyr age_ref age2 sex_ref ref_race marital1 educ_ref fam_size perslt18 persot64 state totexpcq foodcq alcbevcq houscq apparcq transcq healthcq entertcq perscacq readcq educacq tobacccq lifinscq misccq cashcocq retpencq etotalc ehousngc etranptc eentrmtc emiscelc perinscq fdhomecq fdawaycq emiscmtc houseqcq housopcq utilcq gasmocq pubtracq othhexcq totexppq foodpq alcbevpq houspq apparpq transpq healthpq entertpq perscapq readpq educapq tobaccpq lifinspq miscpq cashcopq retpenpq etotalp ehousngp etranptp eentrmtp emiscelp perinspq fdhomepq fdawaypq emiscmtp houseqpq housoppq utilpq gasmopq pubtrapq othhexpq fincbtax fincatax fsalaryx fnonfrmx ffrmincx frretirx fssix famtfedx fsltaxx age_ref_ age2_ educ0ref fam__ize mari_al1 pers_t18 pers_t64 ref__ace sex_ref_ state_
sort year quarter newid

***label variables***
do "$do/labels/l3_CEX_fmli_labels.do"

qui compress
save "$workdir/CEX/fmli_clean.dta", replace
