/*
Title: mtbi_agg_cex.do
Purpose: Aggregates montly expenditures consistent with the BLS glossary
Author: Cole Campbell
Date Last Modified:08-11-2020
*/

* ===============================================================
* Make consumption variables consistent with Ganong and Noel (2019)
* ===============================================================

* ===============
* Food	
* ===============

* Food at home
	gen foodhome = cost if ///
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790240 | /// average food/non-alcoholic beverages expenditures
		ucc==190904  // food prepared by consumer unit on out-of-town trips
		
* Food away
	gen foodaway = cost if ///
		ucc==190903 | /// food on out-of-town trips
		ucc==190901 | /// food or board at school
		ucc==190902	| /// catered affairs
		ucc==790410 | /// dining out at restaurants, cafeterias, drive-ins, etc. (excluding alcoholic beverages)
		ucc==790430    // school lunches	
		
* Alcohol consumed at home
	gen alchome = cost if /// 
		ucc==790320 | /// other alcoholic beverages for home use
		ucc==790330 | /// beer/wine/other alcohol for home use
		ucc==790310   // beer and wine for home use
		
	
* Alcohol away from home
	gen alcaway = cost if ///
		ucc==790420 | /// alcoholic beverages at restaurants, cafeterias, drive-ins, etc.
		ucc==200900   // alcoholic beverages purchased on trips
		
* ===============
* Household		
* ===============		
		
* Owned dwellings
	gen owndwell = cost if level4=="Owned dwellings"
	
* Rented dwellings
	gen rentdwell = cost if level4=="Rented dwellings"
	
* Other lodging
	gen othlodge = cost if level4=="Other lodging"
	
* Utilities, fuels, and public services
	gen utilities = cost if level3=="Utilities, fuels, and public services"
	
* Personal services
	gen perservice = cost if level4=="Personal services"
	
* Other household expenses
	gen othhhexp = cost if level4=="Other household expenses"
	
* Housekeeping supplies
	gen housekeep = cost if level3=="Housekeeping supplies"
	
* Household textiles
	gen hhtextiles = cost if level4=="Household textiles"
	
* Furniture
	gen furniture = cost if level4=="Furniture"
	
* Floor coverings
	gen floor = cost if level4=="Floor coverings"
	
* Major appliances
	gen mappliance = cost if level4=="Major appliances"

* Small appliances/miscellaneous housewares	
	gen sappliance = cost if level4=="Small appliances, miscellaneous housewares"
	
* Miscellaneous household equipment 
	gen mischhequip = cost if level4=="Miscellaneous household equipment"
	
* ====================
* Apparel and Services	
* ====================

* Men's and boys' apparel
	gen menboy_apparel = cost if level3=="Men and boys"
	
* Women's and girls' apparel 
	gen womengirl_apparel = cost if level3=="Women and girls"
	
* Apparel for children under age 2
	gen infant_apparel = cost if level3=="Children under 2"

* Footwear
	gen footwear = cost if level3=="Footwear"
	
* Other apparel products and services 
	gen othapparel = cost if level3=="Other apparel products and services"
	
* ====================
* Transportation
* ====================	

* Vehicle purchases (net outlay)
	gen vehpurch = cost if level3=="Vehicle purchases (net outlay)"
	
* Vehicle finance charges 
	gen vehfinance = cost if level4=="Vehicle finance charges"
	
* Gasoline and motor oil
	gen gas = cost if level3=="Gasoline and motor oil"

* Maintenance and repairs
	gen vehrepair = cost if level4=="Maintenance and repairs"

* Vehicle insurance
	gen vehins = cost if level4=="Vehicle insurance"

* Public transporation
	gen pubtrans = cost if level3=="Public transportation"

* Vehicle rental, leases, licenses, and other charges
	gen vehother = cost if level4=="Vehicle rental, leases, licenses, and other charges"
	
* ====================
* Health care
* ====================	

* Health insurance
	gen healthins = cost if level3=="Health insurance"

* Medical services
	gen medservice = cost if level3=="Medical services"

* Drugs
	gen drugs = cost if level3=="Drugs"

* Medical supplies
	gen medsupllies = cost if level3=="Medical supplies"
	
* ====================
* Entertainment
* ====================	

* Fees and admissions
	gen fees = cost if level3=="Fees and admissions"
	
* Television, radio, and sound equipment 
	gen tv = cost if level3=="Televisions, radios, sound equipment (thru 2004)" | ///
					 level3=="Audio and visual equipment and services (new 2005)"

* Pets, toys, hobbies, and playground equipment
	gen pets = cost if level3=="Pets, toys, hobbies, and playground equipment"

* Other entertainment equipment and services 
	gen othentertain = cost if level3=="Other entertainment supplies, equipment, and services"
	
* ====================
* Other expenditures
* ====================	

* Personal care products and services
	gen perscare = cost if level2=="Personal care products and services"

* Reading
	gen reading = cost if level2=="Reading"

* Education
	gen education = cost if level2=="Education"

* Tobacco products and smoking supplies
	gen tobacco = cost if level2=="Tobacco products and smoking supplies"

* Miscellaneous
	gen misc = cost if level2=="Miscellaneous"

* Cash contributions
	gen cashcont = cost if level2=="Cash contributions"

* Life, endowment, annuities, and other personal insurance
	gen othins = cost if level3=="Life and other personal insurance"

* Retirement, pensions, and Social Security
	gen pension = cost if level3=="Pensions and Social Security"
