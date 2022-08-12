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
	gen foodhomeT = (cost_=="T") if ///
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790240 | /// average food/non-alcoholic beverages expenditures
		ucc==190904  // food prepared by consumer unit on out-of-town trips
		
* Food away
	gen foodawayT = (cost_=="T") if ///
		ucc==190903 | /// food on out-of-town trips
		ucc==190901 | /// food or board at school
		ucc==190902	| /// catered affairs
		ucc==790410 | /// dining out at restaurants, cafeterias, drive-ins, etc. (excluding alcoholic beverages)
		ucc==790430    // school lunches	
		
* Alcohol consumed at home
	gen alchomeT = (cost_=="T") if /// 
		ucc==790320 | /// other alcoholic beverages for home use
		ucc==790330 | /// beer/wine/other alcohol for home use
		ucc==790310   // beer and wine for home use
		
	
* Alcohol away from home
	gen alcawayT = (cost_=="T") if ///
		ucc==790420 | /// alcoholic beverages at restaurants, cafeterias, drive-ins, etc.
		ucc==200900   // alcoholic beverages purchased on trips
		
* ===============
* Household		
* ===============		
		
* Owned dwellings
	gen owndwellT = (cost_=="T") if level4=="Owned dwellings"
	
* Rented dwellings
	gen rentdwellT = (cost_=="T") if level4=="Rented dwellings"
	
* Other lodging
	gen othlodgeT = (cost_=="T") if level4=="Other lodging"
	
* Utilities, fuels, and public services
	gen utilitiesT = (cost_=="T") if level3=="Utilities, fuels, and public services"
	
* Personal services
	gen perserviceT = (cost_=="T") if level4=="Personal services"
	
* Other household expenses
	gen othhhexpT = (cost_=="T") if level4=="Other household expenses"
	
* Housekeeping supplies
	gen housekeepT = (cost_=="T") if level3=="Housekeeping supplies"
	
* Household textiles
	gen hhtextilesT = (cost_=="T") if level4=="Household textiles"
	
* Furniture
	gen furnitureT = (cost_=="T") if level4=="Furniture"
	
* Floor coverings
	gen floorT = (cost_=="T") if level4=="Floor coverings"
	
* Major appliances
	gen mapplianceT = (cost_=="T") if level4=="Major appliances"

* Small appliances/miscellaneous housewares	
	gen sapplianceT = (cost_=="T") if level4=="Small appliances, miscellaneous housewares"
	
* Miscellaneous household equipment 
	gen mischhequipT = (cost_=="T") if level4=="Miscellaneous household equipment"
	
* ====================
* Apparel and Services	
* ====================

* Men's and boys' apparel
	gen menboy_apparelT = (cost_=="T") if level3=="Men and boys"
	
* Women's and girls' apparel 
	gen womengirl_apparelT = (cost_=="T") if level3=="Women and girls"
	
* Apparel for children under age 2
	gen infant_apparelT = (cost_=="T") if level3=="Children under 2"

* Footwear
	gen footwearT = (cost_=="T") if level3=="Footwear"
	
* Other apparel products and services 
	gen othapparelT = (cost_=="T") if level3=="Other apparel products and services"
	
* ====================
* Transportation
* ====================	

* Vehicle purchases (net outlay)
	gen vehpurchT = (cost_=="T") if level3=="Vehicle purchases (net outlay)"
	
* Vehicle finance charges 
	gen vehfinanceT = (cost_=="T") if level4=="Vehicle finance charges"
	
* Gasoline and motor oil
	gen gasT = (cost_=="T") if level3=="Gasoline and motor oil"

* Maintenance and repairs
	gen vehrepairT = (cost_=="T") if level4=="Maintenance and repairs"

* Vehicle insurance
	gen vehinsT = (cost_=="T") if level4=="Vehicle insurance"

* Public transporation
	gen pubtransT = (cost_=="T") if level3=="Public transportation"

* Vehicle rental, leases, licenses, and other charges
	gen vehotherT = (cost_=="T") if level4=="Vehicle rental, leases, licenses, and other charges"
	
* ====================
* Health care
* ====================	

* Health insurance
	gen healthinsT = (cost_=="T") if level3=="Health insurance"

* Medical services
	gen medserviceT = (cost_=="T") if level3=="Medical services"

* Drugs
	gen drugsT = (cost_=="T") if level3=="Drugs"

* Medical supplies
	gen medsuplliesT = (cost_=="T") if level3=="Medical supplies"
	
* ====================
* Entertainment
* ====================	

* Fees and admissions
	gen feesT = (cost_=="T") if level3=="Fees and admissions"
	
* Television, radio, and sound equipment 
	gen tvT = (cost_=="T") if level3=="Televisions, radios, sound equipment (thru 2004)" | ///
					 level3=="Audio and visual equipment and services (new 2005)"

* Pets, toys, hobbies, and playground equipment
	gen petsT = (cost_=="T") if level3=="Pets, toys, hobbies, and playground equipment"

* Other entertainment equipment and services 
	gen othentertainT = (cost_=="T") if level3=="Other entertainment supplies, equipment, and services"
	
* ====================
* Other expenditures
* ====================	

* Personal care products and services
	gen perscareT = (cost_=="T") if level2=="Personal care products and services"

* Reading
	gen readingT = (cost_=="T") if level2=="Reading"

* Education
	gen educationT = (cost_=="T") if level2=="Education"

* Tobacco products and smoking supplies
	gen tobaccoT = (cost_=="T") if level2=="Tobacco products and smoking supplies"

* Miscellaneous
	gen miscT = (cost_=="T") if level2=="Miscellaneous"

* Cash contributions
	gen cashcontT = (cost_=="T") if level2=="Cash contributions"

* Life, endowment, annuities, and other personal insurance
	gen othinsT = (cost_=="T") if level3=="Life and other personal insurance"

* Retirement, pensions, and Social Security
	gen pensionT = (cost_=="T") if level3=="Pensions and Social Security"
