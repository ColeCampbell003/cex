/*

Name: CEX_mtbi_read.do
Author: Cole Campbell
Date: 08/03/2021
Edited by: Shogher Ohannessian
Edit date: 08/03/2021
Purpose: Read in the CEX mtbi files.
Source: https://www.bls.gov/cex/pumd_data.htm#stata 
Input: CEX mtbi files mtbi`yy'`q'.dta
Output: $workdir/CEX/mtbi.dta
Notes: 

- The variables we are keeping are the following:

	NEWID: Public use microdata identifier
	REF_MO: Reference Month of this expenditure
	REF_YR: Reference Year of this expenditure
	UCC: Universal Classification Code
	COST: Total cost of item, including sales tax
	
- We follow CGK (2012) to construct different definitions of durables, non-durables, etc.

***
*** 1. Import CEX mtbi files 1996-2020
*** 2. Append the CEX mtbi files 1996-2020 
***

*/


***
*** 1. Import CEX mtbi files 1996-2020
***

* 1996-2019 quarters 1x, 2, 3, and 4
	forval y = 2017(01)2019 {
	
		local yy: di %02.0f mod(`y', 100)

		foreach q in 1x 2 3 4 {
			
		* display year and quarter
			di as error "year = `y' quarter = `q'"

		* import mtbi file
			use "$raw/cex/intrvw`yy'/intrvw`yy'/mtbi`yy'`q'.dta", clear
				
		* destring UCC and drop if missing UCC
			destring ucc, replace
			drop if ucc == .
			
		* keep relevant variables
			keep newid ref_yr ref_mo ucc cost cost_

		* destring the unique identifier
			destring newid, replace
			
		* run do files that assigns expenditures to categories -- 
			* Glossary categories
			qui do "$do/s1_mtbi_agg_cex.do"
			
			* CGK categories
			qui do "$do/s1_mtbi_agg_cex_cgk.do"
				
		* run topcode do files
			* Glossary categories
			qui do "$do/s2_mtbi_topcode_cex.do"
			
			* CGK categories
			qui do "$do/s2_mtbi_topcode_cex_cgk.do"
			
		* aggregate monthly expenditures by household
			drop ucc cost_
			order newid ref_mo ref_yr
			qui ds newid ref_mo ref_yr level*, not
			collapse (sum) `r(varlist)', by(newid ref_mo ref_yr)
			
		* create year and quarter variables
			gen year = `y'
			gen quarter = "`q'"

		* compress and save
			qui compress 
			save "$workdir/cex/mtbi_`y'_q`q'.dta", replace
		}
	}

* 1996-2019 quarter 1
	forval y = 2016(01)2019 {
	
		local yy: di %02.0f mod(`y', 100)

		foreach q in 1 {
			
		* display year and quarter
			local y = `y' + 1
			local yyplus1: di %02.0f mod(`y', 100)
			di as error "year = `y' quarter = `q'"

		* import mtbi file
			use "$raw/cex/intrvw`yy'/intrvw`yy'/mtbi`yyplus1'`q'.dta", clear
				
		* destring UCC and drop if missing UCC
			destring ucc, replace
			drop if ucc == .
			
		* keep relevant variables
			keep newid ref_yr ref_mo ucc cost cost_

		* destring the unique identifier
			destring newid, replace
			
		* run do files that assigns expenditures to categories -- 
			* Glossary categories
			qui do "$do/s1_mtbi_agg_cex.do"
			
			* CGK categories
			qui do "$do/s1_mtbi_agg_cex_cgk.do"
				
		* run topcode do files
			* Glossary categories
			qui do "$do/s2_mtbi_topcode_cex.do"
			
			* CGK categories
			qui do "$do/s2_mtbi_topcode_cex_cgk.do"
			
		* aggregate monthly expenditures by household
			drop ucc cost_
			order newid ref_mo ref_yr
			qui ds newid ref_mo ref_yr level*, not
			collapse (sum) `r(varlist)', by(newid ref_mo ref_yr)
			
		* create year and quarter variables
			gen year = `y'
			gen quarter = "`q'"

		* compress and save
			qui compress 
			save "$workdir/cex/mtbi_`y'_q`q'.dta", replace
		}
	}
	
* 2020 quarters 2 and 3
	foreach y in 2020 {
		local yy: di %02.0f mod(`y', 100)

		foreach q in 2 3 {
			
		* display year and quarter
			di as error "year = `y' quarter = `q'"

		* import mtbi file
			use "$raw/cex/intrvw`yy'/intrvw`yy'/mtbi`yy'`q'.dta", clear
				
		* destring UCC and drop if missing UCC
			destring ucc, replace
			drop if ucc == .
			
		* keep relevant variables
			keep newid ref_yr ref_mo ucc cost cost_

		* destring the unique identifier
			destring newid, replace
			
		* run do files that assigns expenditures to categories -- 
			* Glossary categories
			qui do "$do/s1_mtbi_agg_cex.do"
			
			* CGK categories
			qui do "$do/s1_mtbi_agg_cex_cgk.do"
				
		* run topcode do files
			* Glossary categories
			qui do "$do/s2_mtbi_topcode_cex.do"
			
			* CGK categories
			qui do "$do/s2_mtbi_topcode_cex_cgk.do"			
			
		* aggregate monthly expenditures by household
			drop ucc cost_
			order newid ref_mo ref_yr
			qui ds newid ref_mo ref_yr level*, not
			collapse (sum) `r(varlist)', by(newid ref_mo ref_yr)
			
		* create year and quarter variables
			gen year = `y'
			gen quarter = "`q'"

		* compress and save
			qui compress 
			save "$workdir/cex/mtbi_`y'_q`q'.dta", replace
		}
	}


***
*** 2. Append the CEX mtbi files 1996-2020 
***
	clear
	
* loop through and append files together
	forvalues y = 2017(01)2020 { 
		foreach q in 1 2 3 4 1x {
			di as error "year = `y' quarter = `q'"
			
		* append
			cap noisily: append using "$workdir/cex/mtbi_`y'_q`q'.dta"

		/** address survey breaks by only keeping those that merge with the family files
			if (`y' == 2005 & "`q'" == "1") {
				save "$workdir/CEX/mtbi.dta", replace
				merge m:1 newid using "$workdir/CEX/fmli_`y'_q`q'.dta", keepusing(newid) keep(3) nogen
				cap noisily: append using "$workdir/CEX/mtbi.dta"
			}*/
		}
	}
	
* create year-month and year-quarter date variables	
	destring ref_yr, replace
	destring ref_mo, replace
	
* monthly date
	gen refymdate = ym(ref_yr, ref_mo) 
	format refymdate %tm
	
* quarterly date
	gen refqdate = qofd(dofm(refymdate))
	format refqdate %tq
	
* compress and save
	qui compress
	save "$workdir/cex/mtbi.dta", replace
