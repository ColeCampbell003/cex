/*

Name: CEX_fmli_read.do
Author: Shogher Ohannessian
Date: 07/29/2021
Edited by:
Edit date: 
Purpose: Read in the CEX fmli files.
Source: https://www.bls.gov/cex/pumd_data.htm#stata 
Input: CEX fmli files fmli`yy'`q'.dta
Output: $workdir/CEX/fmli.dta
Notes: 

- The variables we are keeping are the following:

		***ID, weight, interview month, interview year***
		NEWID: Public use microdata identifier
		FINLWT21: Calibration final weight for the full sample
		QINTRVMO: Interview month
		QINTRVYR: Interview year

		****Demographics***
		AGE_REF: Age of reference person
		AGE2: Age of spouse
		SEX_REF: Sex of reference person
		REF_RACE: Race of reference person
		MARITAL1: Marital status of reference person
		EDUC_REF: Education of reference person
		FAM_SIZE: Number of Members in CU
		PERSLT18: # of CU Members less than 18 AGE < 18
		PERSOT64: Number of persons over 64 SUM OF MEMBERS WHERE AGE > 64 BY CU
		STATE: Federal information processing standard state code 
		
		****Family Income***
		FINCBTAX: Total amount of family income before taxes in the last 12 months
		FINCATAX: Total amount of family income after taxes in the last 12 months 
		FSALARYX: Total amount of income received from salary or wages before deduction by family grouping
		FNONFRMX: Total amount of income received from non-farm business, partnership or professional practice by family grouping.
		FFRMINCX: Total amount of income or loss received from own farm
		FRRETIRX: Total amount received from Social Security benefits and Railroad Benefit checks prior to deductions for medical insurance and Medicare
		FSSIX: Amount of Supplemental Security Income from all sources received by all CU members in past 12 months 
		FAMTFEDX: Total amount of Federal tax deducted from last pay annualized
		FSLTAXX: Amount of state and local income taxes deducted from last pay annualized for all CU members 

		***Total expenditures this quarter and its components***
		TOTEXPCQ: Total expenditures this quarter
			FOODCQ: Total food this quarter
			ALCBEVCQ: Alcoholic beverages this quarter
			HOUSCQ: Housing this quarter
			APPARCQ: Apparel and services this quarter
			TRANSCQ: Transportation this quarter
			HEALTHCQ: Health care this quarter
			ENTERTCQ: Entertainment this quarter
			PERSCACQ: Personal care this quarter
			READCQ: Reading this quarter
			EDUCACQ: Education current quarter
			TOBACCCQ: Tobacco and smoking supplies this quarter
			LIFINSCQ: Life and other personal insurance this quarter 
			MISCCQ: Miscellaneous expenditures this quarter
			CASHCOCQ: Cash contributions this quarter
			RETPENCQ: Retirement, pensions, Social Security this quarter

		***Total outlays this quarter and its components***
		ETOTALC: Total outlays this quarter, sum of outlays from all major expenditure categories
			FOODCQ: Total food this quarter
			ALCBEVCQ: Alcoholic beverages this quarter
			EHOUSNGC: Total housing outlays this quarter including maintenance, fuels, public services, household operations, house furnishings, and mortgage (lump sum home equity loan or line of credit home equity loan) principle and interest
			APPARCQ: Apparel and services this quarter
			ETRANPTC: Total outlays for transportation this quarter including down payment, principal and finance charges paid on loans, gasoline and motor oil, maintenance and repairs, insurance, public and other transportation, and vehicle rental licenses and other charges
			HEALTHCQ: Health care this quarter
			EENTRMTC: Total entertainment outlays this quarter including sound systems, sports equipment, toys, cameras, and down payments on boats and campers
			PERSCACQ: Personal care this quarter
			READCQ: Reading this quarter
			EDUCACQ: Education current quarter
			TOBACCCQ: Tobacco and smoking supplies this quarter
			EMISCELC: Miscellaneous outlays this quarter including reduction of mortgage principal (lump sum home equity loan) on other property
			CASHCOCQ: Cash contributions this quarter
			PERINSCQ: Personal insurance and pensions this quarter

		***Other expenditures this quarter***
		FDHOMECQ: Food at home this quarter 
		FDAWAYCQ: Food away from home this quarter
		EMISCMTC: Mortgage principal outlays this quarter for other property
		HOUSEQCQ: House furnishings and equipment this quarter
		HOUSOPCQ: Household operations this quarter
		UTILCQ: Utilities, fuels and public services this quarter 
		GASMOCQ: Gasoline and motor oil this quarter
		PUBTRACQ: Public and other transportation this quarter
		OTHHEXCQ: Other household expenses this quarter

		***Total expenditures last quarter and its components***
		TOTEXPPQ: Total expenditures last quarter
			FOODPQ: Total food last quarter
			ALCBEVPQ: Alcoholic beverages last quarter
			HOUSPQ: Housing last quarter
			APPARPQ: Apparel and services last quarter
			TRANSPQ: Transportation last quarter
			HEALTHPQ: Health care last quarter
			ENTERTPQ: Entertainment last quarter
			PERSCAPQ: Personal care last quarter
			READPQ: Reading last quarter
			EDUCAPQ: Education current quarter
			TOBACCPQ: Tobacco and smoking supplies last quarter
			LIFINSPQ: Life and other personal insurance last quarter 
			MISCPQ: Miscellaneous expenditures last quarter
			CASHCOPQ: Cash contributions last quarter
			RETPENPQ: Retirement, pensions, Social Security last quarter

		***Total outlays last quarter and its components***
		ETOTALP: Total outlays last quarter, sum of outlays from all major expenditure categories
			FOODPQ: Total food last quarter
			ALCBEVPQ: Alcoholic beverages last quarter
			EHOUSNGP: Total housing outlays last quarter including maintenance, fuels, public services, household operations, house furnishings, and mortgage (lump sum home equity loan or line of credit home equity loan) principle and interest
			APPARPQ: Apparel and services last quarter
			ETRANPTP: Total outlays for transportation last quarter including down payment, principal and finance charges paid on loans, gasoline and motor oil, maintenance and repairs, insurance, public and other transportation, and vehicle rental licenses and other charges
			HEALTHPQ: Health care last quarter
			EENTRMTP: Total entertainment outlays last quarter including sound systems, sports equipment, toys, cameras, and down payments on boats and campers
			PERSCAPQ: Personal care last quarter
			READPQ: Reading last quarter
			EDUCAPQ: Education current quarter
			TOBACCPQ: Tobacco and smoking supplies last quarter
			EMISCELP: Miscellaneous outlays last quarter including reduction of mortgage principal (lump sum home equity loan) on other property
			CASHCOPQ: Cash contributions last quarter
			PERINSPQ: Personal insurance and pensions last quarter

		***Other expenditures last quarter***
		FDHOMEPQ: Food at home last quarter 
		FDAWAYPQ: Food away from home last quarter
		EMISCMTP: Mortgage principal outlays last quarter for other property
		HOUSEQPQ: House furnishings and equipment last quarter
		HOUSOPPQ: Household operations last quarter
		UTILPQ: Utilities, fuels and public services last quarter 
		GASMOPQ: Gasoline and motor oil last quarter
		PUBTRAPQ: Public and other transportation last quarter
		OTHHEXPQ: Other household expenses last quarter

***
*** 1. Import CEX fmli files 1996-2020
*** 2. Append the CEX fmli files 1996-2020
***

*/


***
*** 1. Import CEX fmli files 1996-2020
***
forval y = 1996(01)2019 {
	local yy: di %02.0f mod(`y', 100)

	foreach q in 1x 2 3 4 {
		di as error "year = `y' quarter = `q'"

		use "$raw/cex/intrvw`yy'/intrvw`yy'/fmli`yy'`q'.dta", clear
			
		qui isvar newid finlwt21 qintrvmo qintrvyr age_ref age2 sex_ref ref_race marital1 educ_ref fam_size perslt18 persot64 state totexpcq foodcq alcbevcq houscq apparcq transcq healthcq entertcq perscacq readcq educacq tobacccq lifinscq misccq cashcocq retpencq etotalc ehousngc etranptc eentrmtc emiscelc perinscq fdhomecq fdawaycq emiscmtc houseqcq housopcq utilcq gasmocq pubtracq othhexcq totexppq foodpq alcbevpq houspq apparpq transpq healthpq entertpq perscapq readpq educapq tobaccpq lifinspq miscpq cashcopq retpenpq etotalp ehousngp etranptp eentrmtp emiscelp perinspq fdhomepq fdawaypq emiscmtp houseqpq housoppq utilpq gasmopq pubtrapq othhexpq fincbtax fincatax fsalaryx fnonfrmx ffrmincx frretirx fssix famtfedx fsltaxx fsalaryx fsmpfrmx othregx welfarex retsurvx othrincx jfs_amt frretirx fssix fincbtax intrdvx royestx netrentx age_ref_ age2_ educ0ref fam__ize mari_al1 pers_t18 pers_t64 ref__ace sex_ref_ state_
		keep `r(varlist)'

		destring newid, replace

		gen quarter = "`q'"
		gen year = `y'

		qui compress 
		save "$workdir/cex/fmli_`y'_q`q'.dta", replace
	}
}

forval y = 1996(01)2019 {
	local yy: di %02.0f mod(`y', 100)

	foreach q in 1 {
		local y = `y' + 1
		local yyplus1: di %02.0f mod(`y', 100)
		di as error "year = `y' quarter = `q'"
				
		use "$raw/cex/intrvw`yy'/intrvw`yy'/fmli`yyplus1'`q'.dta", clear
				
		qui isvar newid finlwt21 qintrvmo qintrvyr age_ref age2 sex_ref ref_race marital1 educ_ref fam_size perslt18 persot64 state totexpcq foodcq alcbevcq houscq apparcq transcq healthcq entertcq perscacq readcq educacq tobacccq lifinscq misccq cashcocq retpencq etotalc ehousngc etranptc eentrmtc emiscelc perinscq fdhomecq fdawaycq emiscmtc houseqcq housopcq utilcq gasmocq pubtracq othhexcq totexppq foodpq alcbevpq houspq apparpq transpq healthpq entertpq perscapq readpq educapq tobaccpq lifinspq miscpq cashcopq retpenpq etotalp ehousngp etranptp eentrmtp emiscelp perinspq fdhomepq fdawaypq emiscmtp houseqpq housoppq utilpq gasmopq pubtrapq othhexpq fincbtax fincatax fsalaryx fnonfrmx ffrmincx frretirx fssix famtfedx fsltaxx fsalaryx fsmpfrmx othregx welfarex retsurvx othrincx jfs_amt frretirx fssix fincbtax intrdvx royestx netrentx age_ref_ age2_ educ0ref fam__ize mari_al1 pers_t18 pers_t64 ref__ace sex_ref_ state_
		keep `r(varlist)'

		destring newid, replace

		gen quarter = "`q'"
		gen year = `y'

		qui compress 
		save "$workdir/cex/fmli_`y'_q`q'.dta", replace
	}
}

foreach y in 2020 {
	local yy: di %02.0f mod(`y', 100)

	foreach q in 2 3 {
		di as error "year = `y' quarter = `q'"

		use "$raw/cex/intrvw`yy'/intrvw`yy'/fmli`yy'`q'.dta", clear
			
		qui isvar newid finlwt21 qintrvmo qintrvyr age_ref age2 sex_ref ref_race marital1 educ_ref fam_size perslt18 persot64 state totexpcq foodcq alcbevcq houscq apparcq transcq healthcq entertcq perscacq readcq educacq tobacccq lifinscq misccq cashcocq retpencq etotalc ehousngc etranptc eentrmtc emiscelc perinscq fdhomecq fdawaycq emiscmtc houseqcq housopcq utilcq gasmocq pubtracq othhexcq totexppq foodpq alcbevpq houspq apparpq transpq healthpq entertpq perscapq readpq educapq tobaccpq lifinspq miscpq cashcopq retpenpq etotalp ehousngp etranptp eentrmtp emiscelp perinspq fdhomepq fdawaypq emiscmtp houseqpq housoppq utilpq gasmopq pubtrapq othhexpq fincbtax fincatax fsalaryx fnonfrmx ffrmincx frretirx fssix famtfedx fsltaxx fsalaryx fsmpfrmx othregx welfarex retsurvx othrincx jfs_amt frretirx fssix fincbtax intrdvx royestx netrentx age_ref_ age2_ educ0ref fam__ize mari_al1 pers_t18 pers_t64 ref__ace sex_ref_ state_
		keep `r(varlist)'

		destring newid, replace

		gen quarter = "`q'"
		gen year = `y'

		qui compress 
		save "$workdir/cex/fmli_`y'_q`q'.dta", replace
	}
}


***
*** 2. Append the CEX fmli files 1996-2020
***
clear

forval y = 1996(01)2020 { 
	foreach q in 1 2 3 4 1x {
		di as error "year = `y' quarter = `q'"

		cap noisily: append using "$workdir/cex/fmli_`y'_q`q'.dta"

		*cap noisily: erase "$workdir/cex/fmli_`y'_q`q'.dta"
	}
}
tab year quarter 

qui compress
save "$workdir/cex/fmli.dta", replace
