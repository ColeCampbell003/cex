/*

Name: c3_CEX_mtbi_fmli_merge.do
Author: Cole Campbell
Date: 12/22/2021
Edited by: 
Edit date: 
Purpose: Clean the appended CEX mtbi dataset.
Source:  
Input: $workdir/CEX/mtbi.dta
Output: $workdir/CEX/mtbi_clean.dta
Notes: 

- Some years have a 1x file and a 1 file for the first quarter of the following year, right now we are using the equivalent of the 1x files for each year except for 2020. 

***
*** 1. Restrict to 1x files
*** 2. Drop weird observations
*** 3. Correct for sample breaks
*** 4. Adjust the variables to inflation
*** 5. Construct different expenditures: nondurables, durables, and services 
*** 6. Aggregate expenditures to the quarterly level
***

*/


* import the spending file
	use "$workdir/cex/mtbi_clean.dta", clear 

* make sure merging variables are the right format
	cap destring quarter, replace
	
* merge with the family file
	merge m:1 year quarter newid using "$workdir/cex/fmli_clean.dta", keep(3) nogen
	keep if ref_yr>=2017
	
* generate date variable for merging
	rename refymdate ym
	format ym %tm	
	
* make income year
	gen inc_year = qintrvyr - 1
	
* create a comparable income variable
	egen income = rowtotal(fsalaryx fnonfrmx ffrmincx frretirx fssix)
	
* save income file for comparison with other
	preserve
	collapse (mean) income fsalaryx fnonfrmx ffrmincx frretirx fssix (first) finlwt21, by(inc_year newid)
	save "$workdir/cex/cex_income.dta", replace
	restore
	
* construct income percentiles by each income year
	bysort inc_year: egen rank2 = rank(income)
	gsort inc_year rank2
	egen rank = group(inc_year rank2)
	drop rank2

	gen percentile = . 
	levelsof inc_year, local(inc_yearl)
	foreach k of local inc_yearl {
		xtile percentile_`k' = income if inc_year == `k', nq(100)
		replace percentile = percentile_`k' if inc_year == `k'
	}
	gen p10 = (inrange(percentile, 0, 10) == 1)
	gen p25 = (inrange(percentile, 0, 25) == 1)
	gen p50 = (inrange(percentile, 0, 50) == 1)
	gen p90 = (inrange(percentile, 90, 100) == 1)
	gen p99 = (inrange(percentile, 99, 100) == 1)

* collapse file to percentile year-month level
	foreach p in 10 25 50 90 99 {
		preserve 
		collapse (mean) totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS misc1 [aw=finlwt21], by(ym p`p')
		drop if p`p' == 0 
		drop p`p'
		gen p = `p'
		tempfile p`p'
		save `p`p''
		restore 
	}

	clear 
	foreach p in 10 25 50 90 99 {
		append using `p`p'' 
	}	
	
* save and zip the dataset
	order ym p totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS misc1
	gsort ym p
	compress 
	gsave "$workdir/cex/spend_monthly_income.dta", replace 	

	
* plot
	preserve
	gcollapse totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS misc1 [aw=finlwt21], by(ym p)
	drop if p==.

	* sort the data
	sort p refymdate
	xtset p refymdate
	
	* create percent changes
	foreach var in totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS misc1 {
		*by p: gen base_`var' = `var'[1]
		*by p: gen pct_`var' = `var'/base_`var'
		gen yoy_`var' = (`var'-L12.`var')/L12.`var'
		egen `var'_50 = mean(`var') if p==50, by(refymdate)
		egen temp = max(`var'_50), by(refymdate)
		gen `var'_9050 = `var'/temp
		drop `var'_50 temp
	}

	* plot levels
	twoway (connected totalexp refymdate if p==50 & refymdate>=703) (connected totalexp refymdate if p==90 & refymdate>=703), legend(label(1 "Bottom 50%") label(2 "Top 10%")) xline(722)
	
	* plot yoy
	twoway (connected yoy_totalexp refymdate if p==50 & refymdate>=703) (connected yoy_totalexp refymdate if p==90 & refymdate>=703), legend(label(1 "Bottom 50%") label(2 "Top 10%")) xline(722)
	
	* plot ratio of spending of 90 to 50th percentiles
	twoway (connected totalexp_9050 refymdate if p==90 & refymdate>=703), xline(722)
	restore
