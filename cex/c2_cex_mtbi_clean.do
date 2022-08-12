/*

Name: c2_CEX_mtbi_clean.do
Author: Cole Campbell
Date: 08/04/2021
Edited by: Shogher Ohannessian
Edit date: 08/04/2021
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


	use "$workdir/CEX/mtbi.dta", clear 


***
*** 1. Restrict to 1x files
***

* Some years have a 1x file and a 1 file for the first quarter of the following year, right now we are using the equivalent of the 1x files for each year except for 2020.
	drop if quarter == "1" & year < 2020 
	replace quarter = "1" if quarter == "1x"

	isid newid ref_mo ref_yr
	
	
***
*** 2. Drop weird observations
***
* drop observations with negative expenditures where there shouldn't be any.
	drop if cgk_elderly < 0 // drops 140 obs
	
* drop observations with zero expenditures
	drop if cgk_totalexp == 0 // drops ~133k obs
	
* Drop interviews with less than 3 months of data. Note: lose  ids
	bys newid: gen count = _N
	drop if count < 3 // drops 101 obs
	drop count
	
* drop households that report zero consumption in any interview
	preserve
	gen food = cgk_foodhome + cgk_foodaway
	collapse (min) food, by(newid)
	drop if food == 0 // drops 3,435 obs
	count // count # of households after dropping zero-food households
	drop food
	sort newid
	save "$workdir/temp.dta", replace
	restore
	
	merge m:1 newid using "$workdir/temp.dta", keep(3) nogen
	cap n rm "$workdir/temp.dta"
	unique newid


***
*** 3. Correct for survey breaks
***	
* merge with the family file to get interview quarter, year, and weights for later
	count
	merge m:1 newid year quarter using "$workdir/cex/fmli.dta", keepusing(qintrvmo qintrvyr finlwt21) keep(3) nogen
	count
	destring qintrvmo qintrvyr, replace
	gen intymdate = ym(qintrvyr, qintrvmo)
	format intymdate %tm
	
* foodaway (break in 2007q2)
	local var = "cgk_foodaway"
	gen dummy = (intymdate < m(2007m4))
	reg `var' dummy refymdate if `var' != 0 & (intymdate < m(2007m4) | intymdate > m(2007m6))
	gen `var'_original = `var'
	replace `var' = `var'_original - dummy*_b[dummy] if `var' != 0 
	drop dummy*
	
* foodhome (break in 2008q2)
	local var = "cgk_foodhome"
	gen dummy = (intymdate < m(2008m2))
	reg `var' dummy refymdate  if `var' != 0 
	gen `var'_original = `var'
	replace `var' = `var'_original - dummy*_b[dummy] if `var' != 0 
	drop dummy*

* perscareS (break in 2001q2)
	local var = "cgk_perscareS"
	gen dummy = (intymdate >= m(2001m4) & intymdate < m(2004m1)) 
	gen dummy2 = (intymdate >= m(2004m1) & intymdate < m(2004m4))
	gen dummy3 = (intymdate >= m(2004m4))
	reg `var' dummy dummy2 dummy3 refymdate if `var' != 0 
	gen `var'_original = `var'
	replace `var' = `var'_original - dummy *_b[dummy]  ///
								  - dummy2*_b[dummy2] ///
								  - dummy3*_b[dummy3] if `var'!=0 
	drop dummy*

* occupexp (break in 2001q2)
	local var = "cgk_occupexp"
	gen dummy = (intymdate >= m(2001m4))
	reg `var' dummy refymdate if `var' != 0 
	gen `var'_original = `var'
	replace `var' = `var'_original - dummy*_b[dummy] if `var' != 0 
	drop dummy* *_original

	
***
*** 4. Adjust the variables to inflation
***
	rename year srvy_year
	clonevar year = ref_yr
	clonevar month = ref_mo

// * merge with inflator
// 	merge m:1 month year using "$workdir/inflation_monthly.dta", keepusing(inflator) keep(master matched) nogen // uses 2020 as reference year
//
// * inflate variables
// 	qui ds newid ref_mo ref_yr srvy_year quarter refymdate refqdate finlwt21 qintrvmo qintrvyr intymdate year month inflator *T, not
// 	foreach var in `r(varlist)' {
// 		replace `var' = `var'*inflator
// 	}
// 	drop inflator year month
// 	rename srvy_year year

	
***
*** 5. Construct different expenditures in our internal doc "Measures of consumption"
***

* Food (FOODCQ)
	gen cgk_foodcq = cgk_foodhome + cgk_foodaway
	
* Alcoholic beverages (ALCBEVCQ)
	gen cgk_alcbevcq = cgk_alc_home + cgk_alc_away
	
* Tobacco (TOBACCQ)
	gen cgk_tobaccq = cgk_tobacco
	
* Apparels and services (APPARCQ)
	gen cgk_apparcq = cgk_clothD + cgk_clothS
	
* Personal care (PERSCACQ)
	gen cgk_perscacq = cgk_perscareD + cgk_perscareS
	
* Gasoline (GASCQ)
	gen cgk_gascq = cgk_gasoline
	
* Reading (READCQ)
	gen cgk_readcq = cgk_reading
	
* Public and other transportation (TRANSCQ)
	gen cgk_transcq = cgk_pubtrans
	
* Household operations (HOUSOPSCQ)
	gen cgk_housopscq = cgk_household + cgk_babysit
	
* Entertainment (ENTERTCQ)
	gen cgk_entertcq = cgk_entertainS + cgk_entertainD
	
* Utilities, fuel, and public services (UTLCQ)
	gen cgk_utlcq = cgk_energy + cgk_phone + cgk_water
	
* Household furnishings and equipment (HOUSFURNCQ)
	gen cgk_housfurncq = cgk_furniture
	
* Education (EDUCACQ)
	gen cgk_educacq = cgk_education
	
* Healthcare (HEALTHCQ)
	gen cgk_healthcq = cgk_healthS + cgk_healthD
	
* Miscellaneous expenditures (MISCCQ)
	gen cgk_misccq = cgk_financialS + cgk_occupexp + cgk_misc1
	
* general measures
	gen food = foodaway + foodhome
	gen alcohol = alchome + alcaway
	gen apparel = menboy_apparel + womengirl_apparel + infant_apparel + footwear + othapparel
	
* Nondurables
	 gen nondurables = food + alcohol + utilities + gas + pubtrans + drugs + tobacco

* Durables
	gen durables = education + apparel + othlodge + housekeep + othhhexp + hhtextiles + furniture + floor + mischhequip + vehrepair + vehother + healthins + othins + vehins + medservice + pets + tv + othentertain + perscare + reading + cashcont 	

* drop topcoded indicators
	foreach var of varlist *T {
		display `var'
		sum `var'
		if `r(mean)' == 0 {
			drop `var'
		}
	}
	
***label variables***
	*do "$do/labels/l5_CEX_mtbi_labels.do"

	qui compress
	save "$workdir/CEX/mtbi_clean.dta", replace	

/*
	
***
*** 6. Aggregate expenditures to the quarterly level
***

* collapse data to the quarter level
	collapse (sum) cost totalexp foodhome foodaway alc_home alc_away clothS ///
	clothD perscareD perscareS reading tobacco gasoline entertainD furniture ///
	jewelry energy babysit elderly water entertainS financialS houseaway phone ///
	pubtrans mortint healthD healthS healthins education cashcont houseexpS ///
	houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay ///
	rentpay occupexp proptax vehpurch vehexpD vehexpS nondurables durables ///
	services nonconsumption nondur nodur_strict food consumption totalexp2 totalexp3 ///
	(max) finlwt21 energyT waterT entertainST houseawayT phoneT pubtransT healthDT ///
	healthST healthinsT houseexpST houseexpDT householdT rentexpDT rentexpST ///
	rentpaidT occupexpT proptaxT vehexpST, ///
	by(refqdate year quarter newid qintrvmo qintrvyr intymdate)
	
	isid newid refqdate 

* order and sort
	order refqdate year quarter newid qintrvmo qintrvyr intymdate finlwt21 cost totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS nondurables durables services nonconsumption nondur nodur_strict food consumption totalexp2 totalexp3 energyT waterT entertainST houseawayT phoneT pubtransT healthDT healthST healthinsT houseexpST houseexpDT householdT rentexpDT rentexpST rentpaidT occupexpT proptaxT vehexpST
	sort refqdate year quarter newid qintrvmo qintrvyr intymdate finlwt21 cost totalexp foodhome foodaway alc_home alc_away clothS clothD perscareD perscareS reading tobacco gasoline entertainD furniture jewelry energy babysit elderly water entertainS financialS houseaway phone pubtrans mortint healthD healthS healthins education cashcont houseexpS houseexpD household rentexpD rentexpS rentpaid lifeins pensions mealspay rentpay occupexp proptax vehpurch vehexpD vehexpS nondurables durables services nonconsumption nondur nodur_strict food consumption totalexp2 totalexp3 energyT waterT entertainST houseawayT phoneT pubtransT healthDT healthST healthinsT houseexpST houseexpDT householdT rentexpDT rentexpST rentpaidT occupexpT proptaxT vehexpST

***label variables***
	do "$do/labels/l5_CEX_mtbi_labels.do"

	qui compress
	save "$workdir/CEX/mtbi_clean.dta", replace
*/
