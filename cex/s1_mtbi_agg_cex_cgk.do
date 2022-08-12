/*
Title: mtbi_agg_cex.do
Purpose: Aggregates montly expenditures consistent with Coibon et al. (2012).
Author: Cole Campbell
Date Last Modified:08-11-2020
*/

* ===============================================================
* make consumption variables consistent with Coibon et al. (2012)
* classification are based on NIPA, Chapter 5: 'Consumer Spending'
* ===============================================================
/*Total Expenditures*/
gen	cgk_totalexp = cost if  				///
	ucc==	2120	|					///
	ucc>=	190901	& ucc<= 220322 |	///				
	ucc>=	220901	& ucc<= 450110 |	///				
	ucc==	450210	|					///
	ucc==	450220	|					///
	ucc>=	450310	& ucc<= 450414 |	///				
	ucc==	460110	|					///
	ucc>=	460901	& ucc<= 460902 |	///				
	ucc>=	470111	& ucc<= 600122 |	///				
	ucc>=	600131	& ucc<= 600132 |	///				
	ucc>=	600141	& ucc<= 600142 |	///				
	ucc>=	600210	& ucc<= 710110 |	///				
	ucc>=	790220	& ucc<= 790600 |	///				
	ucc==	790690	|					///
	ucc==	800111	|					///
	ucc==	800121	|					///
	ucc>=	800700	& ucc<= 800710 |	///				
	ucc==	800801	|					///
	ucc>=	800804	& ucc<= 800940 |	///				
	ucc==	850300	|					///
	ucc==	880110	|					///
	ucc==	880210	|					///
	ucc==	880310	|					///
	ucc>=	900001	& ucc<= 900002 |	///				
	ucc>=	990900	& ucc<= 990940


/*NON-DURABLE CONSUMPTION*/
* food at home
	gen cgk_foodhome = cost if ///
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790230 | /// food or non-alcoholic beverages purchased at convenience stores
		ucc==790220 | /// food or non-alcoholic beverages purchased at grocery stores
		ucc==790240 | /// average food/non-alcoholic beverages expenditures
		ucc==190904  // food prepared by consumer unit on out-of-town trips

	
* food away
	gen cgk_foodaway = cost if ///
		ucc==190903 | /// food on out-of-town trips
		ucc==190901 | /// food or board at school
		ucc==190902	| /// catered affairs
		ucc==790410 | /// dining out at restaurants, cafeterias, drive-ins, etc. (excluding alcoholic beverages)
		ucc==790430    // school lunches
		
		
* alcohol consumed at home
	gen cgk_alc_home = cost if /// 
		ucc==790320 | /// other alcoholic beverages for home use
		ucc==790330 | /// beer/wine/other alcohol for home use
		ucc==790310   // beer and wine for home use
		
	
* alcohol away from home
	gen cgk_alc_away = cost if ///
		ucc==790420 | /// alcoholic beverages at restaurants, cafeterias, drive-ins, etc.
		ucc==200900   // alcoholic beverages purchased on trips
		
		
* clothing services
	gen cgk_clothS = cost if ///
		ucc==440110 | /// shoe repair and other shoe service
		ucc==440120 | /// coin-operated apparel laundry and dry cleaning
		ucc==440130 | /// alteration, repair and tailoring of apparel and accessories
		ucc==440140 | /// clothing rental
		ucc==440150 | /// watch and jewelry repair
		ucc==440210 | /// apparel laundry and dry cleaning not coin-operated
		ucc==440900   // clothing storage
		
		
* clothing durables
	gen cgk_clothD = cost if ///
		ucc==360110 | /// men's suits 					/*men ages 16 and over*/
		ucc==360120 | /// men's sportcoats tailored jackets
		ucc==360210 | /// men's coats and jackets
		ucc==360311 | /// men's underwear
		ucc==360312 | /// men's hosiery
		ucc==360320 | /// men's nightwear
		ucc==360330 | /// men's accessories
		ucc==360340 | /// men's sweaters and vests
		ucc==360350 | /// men's active sportswear
		ucc==360410 | /// men's shirts
		ucc==360511 | /// men's pants (thru Q20071)
		ucc==360512 | /// men's shorts shorts sets (thru Q20071)
		ucc==360513 | /// men's pants and shorts (new ucc Q20072)
		ucc==360901 | /// men's uniforms
		ucc==360902 | /// men's costumes
		ucc==370110 | /// boys' coats and jackets 		/*boys ages 2 to 15*/
		ucc==370120 | /// boys' sweaters
		ucc==370130 | /// boys' shirts
		ucc==370211 | /// boys' underwear
		ucc==370212 | /// boys' nightwear
		ucc==370213 | /// boys' hosiery
		ucc==370220 | /// boys' accessories
		ucc==370311 | /// boys' suits sportcoats vests
		ucc==370312 | /// boys' pants (thru Q20071)
		ucc==370313 | /// boys' shorts shorts sets (thru Q20071)
		ucc==370314 | /// boys' pants and shorts (new ucc Q20072)
		ucc==370901 | /// boy's uniforms, active sports wear (split into ucc 370903 and 370904)
		ucc==370902 | /// boys' costumes
		ucc==370903 | /// boys' uniforms
		ucc==370904 | /// boys' active sportswear
		ucc==380110 | /// women's coats and jackets		/*women ages 16 and over*/
		ucc==380210 | /// women's dresses
		ucc==380311	| /// women's sportcoats tailored jackets
		ucc==380312	| /// women's vests and sweaters
		ucc==380313	| /// women's shirts tops blouses
		ucc==380320	| /// women's skirts
		ucc==380331	| /// women's pants (thru Q20071)
		ucc==380332	| /// women's shorts shorts sets (thru Q20071)
		ucc==380333	| /// women's pants and shorts (new ucc Q20072)
		ucc==380340	| /// women's active sportswear
		ucc==380410	| /// women's sleepwear
		ucc==380420	| /// women's undergarments
		ucc==380430	| /// women's hosiery
		ucc==380510	| /// women's suits
		ucc==380901	| /// women's accessories
		ucc==380902	| /// women's uniforms
		ucc==380903	| /// women's costumes
		ucc==390110	| /// girls' coats and jackets		/*girls aged 2 to 15*/
		ucc==390120	| /// girls' dresses and suits
		ucc==390210	| /// girls' shirts blouses sweaters
		ucc==390221	| /// girls' skirts and pants (thru Q20071)
		ucc==390222	| /// girls' shorts shorts sets (thru Q20071)
		ucc==390223	| /// girls' skirts pants and shorts (new ucc Q20072)
		ucc==390230	| /// girls' active sportswear
		ucc==390310	| /// girls' underwear and sleepwear
		ucc==390321	| /// girls' hosiery
		ucc==390322	| /// girls' accessories
		ucc==390901	| /// girls' uniforms
		ucc==390902	| /// girls' costumes
		ucc==410110	| /// infant coat jacket snowsuit		/*infant children under 2*/
		ucc==410111	| /// infant Coats, Jackets, and Snowsuits 9B (deleted 91Q2)
		ucc==410112	| /// infant Coats, Jackets, and Snowsuits 9A (deleted 91Q2)
		ucc==410120	| /// infant dresses outerwear
		ucc==410121	| /// infant Dresses and Outerwear 9B (deleted 91Q2)
		ucc==410122	| /// infant Dresses and Outerwear 9A (deleted 91Q2)
		ucc==410130	| /// infant underwear
		ucc==410131	| /// infant Undergarments 9B, Including Diapers (deleted 91Q2)
		ucc==410132	| /// infant Undergarments 9A, Including Diapers (deleted 91Q2)
		ucc==410140	| /// infant nightwear loungewear
		ucc==410141	| /// infant Sleeping Garments 9B (deleted 91Q2)
		ucc==410142	| /// infant Sleeping Garments 9A (deleted 91Q2)
		ucc==410901	| /// infant accessories
		ucc==410902	| /// infants' other clothing (deleted 91)
		ucc==410903	| /// infant accessories 9A (deleted 91Q2)
		ucc==410904	| /// infant hosiery, footwear, and other clothing (deleted 91Q2)
		ucc==400110	| /// men's footwear		/*footwear*/
		ucc==400210	| /// boys' footwear
		ucc==400220	| /// girls' footwear
		ucc==400310	| /// women's footwear
		ucc==420110	| /// material for making clothes		/*miscellaneous*/
		ucc==420120	| /// sewing patterns and notions
		ucc==640430   // adult diapers
		
		
* personal care durables
	gen cgk_perscareD = cost if ///
		ucc==640130 | /// wigs and hairpieces
		ucc==640420   // electronic personal care appliances
		

* personal care services
	gen cgk_perscareS = cost if ///
		ucc==650310 | /// personal care services
		ucc==650110 | /// personal care service for females (old)
		ucc==650210 | /// personal care service for males (old)
		ucc==650900   // repair of personal care appliances
		
		
* reading
	gen cgk_reading = cost if ///
		ucc==590110 | /// newspapers
		ucc==590111 | /// newspaper subscriptions
		ucc==590112 | /// newspapers, non-subscriptions
		ucc==590310 | /// newspaper, magazine by subscription
		ucc==590410 | /// newspaper, magazine non-subscription
		ucc==590210 | /// magazines
		ucc==590211 | /// magazine subscriptions
		ucc==590212 | /// magazine non-subscriptions
		ucc==660310 | /// encyclopedia and other sets of reference books
		ucc==590220 | /// books thru book clubs
		ucc==590230   // books not thru book clubs
		

* tobacco
	gen cgk_tobacco = cost if  ///
		ucc==630110 | /// cigarettes
		ucc==630210   // other tobacco products
		
		
* gasoline and other transportation fuel
	gen cgk_gasoline = cost if  ///
		ucc==470111 | /// gasoline
		ucc==470113 | /// gasoline on out-of-town trips
		ucc==470112 | /// diesel fuel
		ucc==470211 | /// motor oil
		ucc==470212   // motor oil on out-of-town trips
		
		
/*DURABLE CONSUMPTION*/
* entertainment durables
	gen cgk_entertainD = cost if ///
		ucc==310110 | /// black and white tv		/*audio/visual equipment*/
		ucc==310120 | /// color tv - console
		ucc==310130 | /// color tv - portable, table model
		ucc==310140 | /// televisions
		ucc==310210 | /// vcr''s and video disc players
		ucc==310220 | /// video cassettes, tapes, and discs
		ucc==310232 | /// video game hardware and accessories
		ucc==310231 | /// video game software
		ucc==310230 | /// video game hardware and software
		ucc==310400 | /// applications, games, ringtones for handheld devices
		ucc==690119 | /// computer software
		ucc==690111 | /// computers and computer hardware for nonbusiness use
		ucc==690110 | /// computers for non-business
		ucc==690112 | /// computer software and accessories for nonbusiness use
		ucc==690120 | /// computer accessories
		ucc==690117 | /// portable memory
		ucc==310311 | /// radios
		ucc==310312 | /// phonographs
		ucc==310313 | /// tape recorders and players
		ucc==310340 | /// cd's, records, and audio tapes
		ucc==310342 | /// records, CDs, audio tapes, needles
		ucc==310314 | /// personal digital audo players
		ucc==310320 | /// sound components and component systems
		ucc==310330 | /// accessories and other sound equipment
		ucc==310333 | /// accessories and other sound equipment
		ucc==310334 | /// satellite dishes
		ucc==690118 | /// digital book readers
		ucc==610130 | /// musical instruments and accessories
		ucc==610320 | /// pet purchase, supplies, medicine		/*pets, toys, hobbies, and playground equipment*/
		ucc==610110 | /// toys, games, arts and crafts, and tricycles
		ucc==610120 | /// playground equipment
		ucc==610140 | /// stamp and coin collecting
		ucc==600121 | /// boat without motor and boat trailers		/*unmotored recreational vehicles*/
		ucc==600127 | /// trade-in allowance for boat without motor or non camper-type trailer, such as for boat or cycle
		ucc==600128 | /// trade-in allowance for trailer-type or other attachable-type camper
		ucc==600122 | /// trailer and other attachable campers
		ucc==600132 | /// purchase of boat with motor		/*motored recreational vehicles*/
		ucc==600138 | /// trade-in allowance for boat with motor
		ucc==600131 | /// motorized camper coach or other vehicle
		ucc==600137 | /// trade-in allowance for trailer-type or other attachable-type camper
		ucc==600144 | /// trade-in allowance, other vehicle
		ucc==600142 | /// purchase of other vehicle
		ucc==600900 | /// water sports and miscellaneous sports equipment		/*sports, recreation, and exercise equipment*/
		ucc==600901 | /// water sports equipment
		ucc==600430 | /// winter sports equipment
		ucc==600902 | /// other sports equipment
		ucc==600210 | /// athletic gear, game tables, and exercise equipment
		ucc==600310 | /// bicycles
		ucc==600410 | /// camping equipment
		ucc==600420 | /// hunting and fishing equipment
		ucc==610230 | /// photographic equipment 		/*photographic equipment*/
		ucc==610210   // film
		
		
* furniture
	gen cgk_furniture = cost if ///
		ucc==280110 | /// bathrooom linens		/*household textiles*/
		ucc==280120 | /// bedroom linens
		ucc==280140 | /// kitchen, dining room, and other linens
		ucc==280900 | /// other linens
		ucc==280210 | /// curtains and draperies
		ucc==280230 | /// sewing materials for slipcovers, curtains, other sewing materials for the home
		ucc==280220 | /// slipcovers, decorative pillows
		ucc==290110 | /// mattress and springs		/*furnitures*/
		ucc==290120 | /// other bedroom furnitures 
		ucc==290210 | /// sofas
		ucc==290310 | /// living room chairs
		ucc==290320 | /// living room tables
		ucc==290410 | /// kitchen, dining room furnitures 
		ucc==290440 | /// wall units, cabinets and other occasional furniture
		ucc==290420 | /// infants furniture 
		ucc==320901 | /// office furniture for home-use
		ucc==290430 | /// outdoor furniture 
		ucc==340904 | /// furniture rental
		ucc==320110 | /// room size rugs and other floor covering, nonpermanent		/*floor covering*/
		ucc==220614 | /// installed wall-to-wall carpeting
		ucc==220511 | /// wall-to-wall carpet not installed, capital improvement (owned home)
		ucc==230131 | /// wall-to-wall carpet, installed (renter)
		ucc==230132 | /// wall-to-wall carpet, installed (replacement)(owned home)
		ucc==320162 | /// wall-to-wall carpet, not installed (replacement)
		ucc==320161 | /// wall-to-wall carpet, not installed carpet squares (renter)
		ucc==320111 | /// floor coverings, nonpermanent
		ucc==300112 | /// refrigerators, freezers (owned home)		/*major appliances*/
		ucc==300111 | /// refrigerators, freezers (renter)
		ucc==300312 | /// cooking stoves, ovens (owned home)
		ucc==300311 | /// cooking stoves, ovens (renter)
		ucc==300322 | /// microwave ovens (owned home)
		ucc==300321 | /// microwave ovens (renter)
		ucc==220612 | /// dishwasher, disposal, or range hood
		ucc==230118 | /// dishwashers (built-in), garbage disposals, range hoods, (owned home)
		ucc==230117 | /// dishwashers (built-in), garbage disposals, range hoods, (renter)
		ucc==300332 | /// portable dishwasher (owned home)
		ucc==300331 | /// portable dishwasher (renter) 
		ucc==300212 | /// washing machines (owned home)
		ucc==300211 | /// washing machines (renter)
		ucc==300217 | /// clothes washer or dryer (owned home)
		ucc==300216 | /// clothes washer or dryer (renter)
		ucc==300216 | /// clothes dryer (owned home)
		ucc==300221 | /// clothes dryer (renter)
		ucc==300412 | /// window air conditioners (owned home)
		ucc==300411 | /// window air conditioners (renter)
		ucc==320511 | /// electric floor cleaning equipment
		ucc==320512 | /// sewing machines
		ucc==320521 | /// small electric kitchen appliances/* small appliances, miscellaneous houseware*/
		ucc==320320 | /// china and other dinnerware
		ucc==320310 | /// plastic dinnerware
		ucc==320345 | /// dinnerware, glassware, serving pieces
		ucc==320330 | /// flatware 
		ucc==320360 | /// other serving pieces
		ucc==320350 | /// silver serving pieces
		ucc==320370 | /// nonelectric cookware
		ucc==320522 | /// portable heating and cooling equipment 
		ucc==320120 | /// window coverings		/*miscellaneous household equipment*/
		ucc==320130 | /// infant's equipment 
		ucc==320150 | /// outdoor equipment 
		ucc==320210 | /// clocks
		ucc==320233 | /// clocks and other decorative items
		ucc==320410 | /// lawn and garden equipment 
		ucc==320903 | /// indoor plants, fresh flowers
		ucc==320220 | /// lamps and lighting fixtures
		ucc==320230 | /// other household decorative items
		ucc==320231 | /// other household decorative items
		ucc==690210 | /// telephone answering devices
		ucc==320232 | /// telephones and accessories
		ucc==320420 | /// power tools
		ucc==320902 | /// hand tools
		ucc==320904 | /// closet and storage items
		ucc==430130 | /// luggage
		ucc==690115 | /// personal digital assistants
		ucc==690116 | /// internet services away from home
		ucc==690220 | /// calculators
		ucc==690230 | /// business equipment for home use
		ucc==690242 | /// smoke alarms (owned home)
		ucc==690241 | /// smoke alarms (renter)
		ucc==690245 | /// other household appliances (owned home)
		ucc==690244   // other household appliances (renter)
		
		
* jewelry
	gen cgk_jewelry = cost if /// 
		ucc==430110 | /// watches
		ucc==430120   // jewelry
		
		
/*SERVICE CONSUMPTION*/
* household utilities
	gen cgk_energy = cost if /// 
		ucc==260212 | /// utility--natural gas (owned home)		/*natural gas*/
		ucc==260213 | /// utility--natural gas (owned vacation)
		ucc==260214 | /// utility--natural gas (rented vacation)
		ucc==260211 | /// utility--natural gas (renter)
		ucc==260112 | /// electricity (owned home)		/*electric*/
		ucc==260113 | /// electricity (owned vacation)
		ucc==260114 | /// electricity (rented vacation)
		ucc==260111 | /// electricity (renter)
		ucc==250211	| /// gas btld/tank (renter)		/*bottled gas*/
		ucc==250212	| /// gas btld/tank (owned home)
		ucc==250213	| /// gas btld/tank (owned vacation)
		ucc==250214	|  /// gas btld/tank (rented vacation)
		ucc==250112 | /// fuel oil (owned home)		/*other fuel*/
		ucc==250113 | /// fuel oil (owned vacation)
		ucc==250114 | /// fuel oil (rented vacation)
		ucc==250111 | /// fuel oil (renter)
		ucc==250902 | /// wood/other fuels (owned home)		/*coal, wood, other fuels*/
		ucc==250903 | /// wood/other fuels (owned vacation)
		ucc==250904 | /// wood/other fuels (rented vacation)
		ucc==250222 | /// coal (owned home)
		ucc==250223 | /// coal (owned vacation)
		ucc==250221 | /// coal (renter)
		ucc==250912 | /// coal, wood, other fuels (owned home)
		ucc==250913 | /// coal, wood, other fuels (owned vacation)
		ucc==250914 | /// coal, wood, other fuels (rented vacation)
		ucc==250911   // coal, wood, other fuels (renter)
		
		
* baby sitting
	gen cgk_babysit = cost if /// 
		ucc==340210 | /// babysitting and child care
		ucc==340212 | /// babysitting and child care in someone else's home
		ucc==340211 | /// babysitting and child care in your own home
		ucc==670310   // day care centers, nusery, and preschools
		
		
* elderly care
	gen cgk_elderly = cost if ///
		ucc==340906 | /// care for elderly, invalids, handicapped, etc.
		ucc==340910   // adult day care centers
		
		
* water and other public services
	gen cgk_water = cost if ///
		ucc==270212 | /// water/sewer maint. (owned home)		/*water and sewage maintenance*/
		ucc==270213 | /// water/sewer maint. (owned vacation)
		ucc==270214 | /// water/sewer maint. (rented vacation)
		ucc==270211 | /// water/sewer maint. (renter)
		ucc==270412 | /// trash/garb. collection (owned home)		/*trash and garbage collection*/
		ucc==270413 | /// trash/garb. collection (owned vacation)
		ucc==270414 | /// trash/garb. collection (rented vacation)
		ucc==270411 | /// trash/garb. collection (renter)
		ucc==270902 | /// septic tank cleaning (owned home)		/*septic tank*/
		ucc==270903 | /// septic tank cleaning (owned vacation)
		ucc==270904 | /// septic tank cleaning (rented vacation)
		ucc==270901   // septic tank cleaning (renter)
		
		
* entertainment services
	gen cgk_entertainS = cost if ///
		ucc==610900 | /// recreation expenses, out-of-town trips		/*fees and admission*/
		ucc==620310 | /// fees for recreation lessons
		ucc==620121 | /// fees for participant sports
		ucc==620110 | /// club membership dues and fees
		ucc==620111 | /// social, recreation, health club membership
		ucc==680905 | /// vacation clubs
		ucc==620212 | /// movie, other admissions, out-of-town trips
		ucc==620211 | /// movie, theater, amusement parks, and other
		ucc==620221 | /// admission to sporting events
		ucc==620222 | /// admission to sporting events, out-of-town trips
		ucc==620214 | /// movies, parks, and museums
		ucc==620215 | /// tickets to movies (starts in 2017)
		ucc==620216 | /// tickets to parks or museums (starts in 2017)
		ucc==620903 | /// other entertainment services, out-of-town trips
		ucc==680904 | /// dating services
		ucc==620213 | /// play, theater, oper, concert (starts 2013)
		ucc==620320 | /// photographer fees				/*audio-video, photographic, and information processing equipment services*/
		ucc==620330 | /// photo proccessing
		ucc==620905 | /// repair and rental of photographic equipment
		ucc==310341 | /// compact disc, tape, record and video mail order clubs
		ucc==310240 | /// streaming, downloading video
		ucc==270310 | /// cable and satellite television services
		ucc==690350 | /// installation of other video equipment or sound systems
		ucc==690330 | /// installation of satellite television equipment
		ucc==690340 | /// installation of sound systems
		ucc==690320 | /// installation of televisions
		ucc==270311 | /// satellite radio services
		ucc==310243 | /// rental, streaming, downloading video
		ucc==620918 | /// rental of video software
		ucc==620917 | /// rental of video hardware/accessories
		ucc==340905 | /// rental of vcr, radio, and sound equipment
		ucc==340902 | /// rental of televisions
		ucc==340610 | /// repair of tv, radio, and sound equipment
		ucc==310350 | /// streaming, downloading audio
		ucc==620912 | /// rental of video cassettes, tapes, films, and discs
		ucc==620916 | /// rental of computer and video game hardware and software
		ucc==620904 | /// rental and repair of musical instruments
		ucc==620930 | /// online gaming services
		ucc==620926 | /// lotteries and pari-mutuel losses		/*gambling*/
		ucc==520901 | /// docking and landing fees		/*rental of recreational vehicles*/
		ucc==520904 | /// rental noncamper trailer
		ucc==620906 | /// rental of boat
		ucc==620909 | /// rental of campers on out-of-town trips
		ucc==620907 | /// rental campers and other recreational vehicles
		ucc==620921 | /// rental of motorized camper
		ucc==620922 | /// rental of other rv's
		ucc==620919 | /// rental of other vehicles on out-of-town trips
		ucc==520903 | /// aircraft rental
		ucc==520906 | /// aircraft rental, out-of-town trips
		ucc==520907 | /// boat and trailer rental, out-of-town trips
		ucc==600110 | /// outboard motors
		ucc==620908 | /// rental and repair of other miscellaneous sports equipment		/*other recreational services*/
		ucc==680310 | /// live entertainment for recreational services
		ucc==680320 | /// rental of party supplies for catered affairs
		ucc==620410 | /// pet services
		ucc==620420   // vet services
		
		
* financial services
	gen cgk_financialS = cost if ///
		ucc==620112 | /// credit card memberships
		ucc==620115 | /// shopping club membership fees
		ucc==680110 | /// legal fees
		ucc==680210 | /// safe deposit box rental
		ucc==680220 | /// checking accounts, other bank service charges
		ucc==680902 | /// accounting fees
		ucc==680901 | /// cemetery lots, vaults, maintenance fees
		ucc==680140 | /// funeral expenses
		ucc==710110 | /// finance charges exbluding mortgage and vehicle
		ucc==790840   // other charges in sale of other properties
		
		
* accomadations
	gen cgk_houseaway = cost if ///
		ucc==210210 | /// lodging on out-of-town trips
		ucc==210310   // housing while attending school
		
		
* telecommunication services
	gen cgk_phone = cost if /// 
		ucc==270104 | /// phone cards
		ucc==270106 | /// residential telephone inculding VOIP
		ucc==270000 | /// telephone services, including public pay phones
		ucc==270101 | /// residential telephones/pay phones
		ucc==270102 | /// cellular phone service
		ucc==270105 | /// voice over IP service
		ucc==270103   // pager service
		
		
* public transportation
	gen cgk_pubtrans = cost if ///
		ucc==530110 | /// airline fares
		ucc==530210 | /// intercity bus fares
		ucc==530510 | /// intercity train fares
		ucc==530311 | /// intracity mass transit fares
		ucc==530901 | /// ship fares
		ucc==530412 | /// taxi fares and limousine services
		ucc==530411 | /// taxi fares and limousine services on trips
		ucc==530312 | /// local trans. on out-of-town trips
		ucc==530902   // school bus
		
		
/*Parker AER (1999) nonconsumption*/
* mortgage interest expenses
	gen cgk_mortint = cost if ///
		ucc==220311 | /// mortgage interest
		ucc==220312 | /// mortgage interest (owned vacation)
		ucc==880210 | /// interest paid, home equity line of credit (other property)
		ucc==880110 | /// interest paid, home equity line of credit
		ucc==880310 | /// interest paid, home equity line of credit (owned vacation)
		ucc==220313 | /// interest paid, home equity loan
		ucc==220314 | /// interest paid, home equity loan (owned vacation)
		ucc==220321   // prepayment penalty chares
		
		
* healthcare expenditures (durables)
	gen cgk_healthD = cost if ///
		ucc==550110 | /// eyeglasses and contact lenses
		ucc==550320 | /// medical equipment for general use
		ucc==550330 | /// supportive and convalescent medical equipment
		ucc==550340   // hearing aids
		
		
* healthcare expenditures (services)
	gen cgk_healthS = cost if ///
		ucc==570901 | /// rental of medical equipment		/*supplies*/
		ucc==570903 | /// rental of supportive, convalescent medical equipment
		ucc==540000 | /// perscription drugs (NOT SURE ABOUT THIS ONE)		/*medical services*/
		ucc==560320 | /// services by practioner other than physician
		ucc==560400 | /// service by professionals other than physician
		ucc==560410 | /// non physician services inside the home (starts 2017)
		ucc==560420 | /// non physician services outside home
		ucc==560110 | /// physician's services
		ucc==560210 | /// dental services
		ucc==560310 | /// eyecare services
		ucc==560330 | /// lab test, x-rays
		ucc==570220 | /// care in convalescent or nursing home
		ucc==560900 | /// nursing/therapy/misc. medical services
		ucc==570111 | /// hospital room and services
		ucc==570110 | /// hospital room
		ucc==570210 | /// hospital service other than room
		ucc==570240 | /// medical care in retirement community
		ucc==570230   // other medical care services
		
		
* health insurance expenses
	gen cgk_healthins = cost if  /// /*bcbs = blue cross blue shield*/
		ucc==580110 | /// commercial health insurance
		ucc==580310 | /// health maintenance plans
		ucc==580114 | /// preferred provider health plan (bcbs)
		ucc==580113 | /// preferred provider health plan (not bcbs)
		ucc==580112 | /// traditional fee for service health plan (bcbs)
		ucc==580111 | /// traditional fee for service health plan (not bcbs)
		ucc==580906 | /// other health insurance (bcbs) 
		ucc==580905 | /// other health insurance (not bcbs) 
		ucc==580116 | /// fee for service health plan (bcbs)
		ucc==580115 | /// fee for service health plan (not bcbs)
		ucc==580312 | /// health maintenance organization (bcbs)
		ucc==580311 | /// health maintenance organization (not bcbs)
		ucc==580210 | /// blue cross/blue shield
		ucc==580901 | /// medicare payments
		ucc==580904 | /// commercial medicare supplement (bcbs)
		ucc==580903 | /// commercial medicare supplement (not bcbs)
		ucc==580907 | /// medicare perscripton drug premium
		ucc==580412 | /// dental care insurance (bcbs) (start 2017)
		ucc==580411 | /// dental care insurance (not bcbs) (start 2017)
		ucc==580400 | /// long term care insurance
		ucc==580402 | /// long term care insurance (bcbs) (start 2017)
		ucc==580401 | /// long term care insurance (not bcbs) (start 2017)
		ucc==580422 | /// prescription drug insurance (bcbs) (start 2017)
		ucc==580421 | /// prescription drug insurance (not bcbs) (start 2017)
		ucc==580432 | /// vision care insurance (bcbs) (start 2017)
		ucc==580442 | /// vision care insurance (bcbs) (start 2017)
		ucc==580431 | /// vision care insurance (not bcbs) (start 2017)
		ucc==580441 | /// vision care insurance (not bcbs) (start 2017)
		ucc==580902   // commercial medicare supplement and other health insurance
		
		
* education
	gen cgk_education = cost if /// 
		ucc==670110 | /// college tuition
		ucc==670210 | /// elementary and high school tuition
		ucc==670902 | /// other school expenses including tuition
		ucc==670901 | /// other school tuition
		ucc==670410 | /// vocational and technical school tuition
		ucc==660110 | /// school books, supplies, equipment for college
		ucc==660900 | /// school books, supplies, equipment for day care, nursery
		ucc==660901 | /// school books, supplies, equipment for day care, nursery
		ucc==660210 | /// school books, supplies, equipment for elementary, high school
		ucc==660902 | /// school books, supplies, equipment for other schools
		ucc==660410   // school books, supplies, equipment for vocational and technical schools
		
		
* cash contributions (replaces contribution variables on FMLY files starting in 2001Q2)
	gen cgk_cashcont = cost if /// 
		ucc==800111 | /// alimony expenditures
		ucc==800121 | /// child support expenditures
		ucc==800800 | /// cash gifts/contributions
		ucc==800811 | /// gift to non-CU members of stocks, bonds, and mutual funds
		ucc==810400 | /// gift of out-of-town trip expenses
		ucc==800803 | /// money given to non-CU members, charities, and other organizations
		ucc==800804 | /// support to college students
		ucc==800841 | /// cash contributions to educational institutions
		ucc==800851 | /// cash contributions to political organizations
		ucc==800821 | /// cash contributions to charities and other organizations
		ucc==800831 | /// cash contributions to church, religous organizations
		ucc==800861   // other cash gifts
		
		
* household expenditures (services)
	gen cgk_houseexpS = cost if /// 
		ucc==210901	| /// ground rent		/*maintenance repairs insurance other expenses*/
		ucc==210902	| /// ground rent (vacation homes)
		ucc==220111	| /// fire and extended coverage for owned homes is now included in ucc 220121
		ucc==220112	| /// fire and extended coverage for owned vacation homes
		ucc==220121	| /// homeowners insurance
		ucc==20122	| /// homeowners insurance (vacation homes)
		ucc==230112	| /// painting and papering		/*maintenance and repair services*/
		ucc==230113	| /// plumbing and water heating
		ucc==230114	| /// heat a/c electrical work
		ucc==230115	| /// roofing and gutters
		ucc==230116	| /// contractors' labor and material costs, owned home (now mapped to 230151)
		ucc==230119	| /// same as 230116 - owned vacation home, vacation condos and co-ops (to 230152)
		ucc==230122	| /// repair and replacement of hard surface flooring
		ucc==230123	| /// repair and replacement of hard surface flooring (vacation homes)
		ucc==230142	| /// repair of built-in appliances
		ucc==230151	| /// other repair and maintenance services
		ucc==230152	| /// repair and remodeling services (vacation homes)
		ucc==220901	| /// parking		/*property management and security*/
		ucc==220902	| /// parking (vacation homes)
		ucc==230901	| /// property management
		ucc==230902	| /// property management (vacation homes)
		ucc==340911	| /// management and upkeep services for security
		ucc==340912	| /// management and upkeep services for security (vacation homes)
		ucc==790600	  // expenses for other properties (vacation homes)
		
		
* household expenditures (durables)
	gen cgk_houseexpD = cost if /// /*maintenance and repair commodities*/
		ucc==240112 | /// paint, wallpaper, and supplies (owned vacation)
		ucc==240113 | /// paints, wallpaper, supplies
		ucc==240122 | /// tools and equipment for painting and wallpapering (owned home)
		ucc==240123 | /// tools and equipment for painting and wallpapering (owned vacation)
		ucc==240212 | /// materials for plaster., panel., siding, windows, doors, screens, awnings
		ucc==240214 | /// materials for plastering, paneling, roofing, gutters, downspouts, siding, windows, doors, screens, and awnings
		ucc==320613 | /// construction materials (owned vacation)
		ucc==240213 | /// materials and equipment for roof and gutters
		ucc==240323 | /// materials and supplies for electrical work, heating or air conditioning jobs (owned vacation)
		ucc==240313 | /// materials and supplies for plumbing or water heating installations and repairs (owned vacation)
		ucc==240223 | /// materials and supplies for repairing outdoor patios, walks, fences, driveways, or permanent swimming pools and masonry, brick, or stucco work (owned vacation)
		ucc==220512 | /// materials and supplies purchased for insulation, dwellings under constr, additions, finishing, remodeling, landscaping, etc.
		ucc==990940 | /// materials for finishing, remolding, building patios, walks or other enclosures owned vacation
		ucc==320623 | /// materials for hard surface flooring
		ucc==320622 | /// materials for hard surface flooring, repair and replacement
		ucc==320632 | /// materials for landscaping maintenance
		ucc==240222 | /// materials for patio, walk, fence, driveway, masonry, brick and stucco work
		ucc==990930 | /// materials to finish basement, remodel rooms or build patios, walks, etc. (maint., repair and repl. - owned properties)
		ucc==990940 | /// material for finishing basements and remodeling rooms
		ucc==320633 | /// materials for landscaping maintenance (owned vacation)
		ucc==240312 | /// plumbing supplies and equipment
		ucc==240313 | /// plumbing supplies and equipment (owned vacation)
		ucc==240322 | /// electrical supplies, heating and cooling equipment
		ucc==240323 | /// electrical supplies, heating and cooling equipment (owned vacation)
		ucc==790610   // contractors labor and materials, supplies CU obtained, apppliances provided by contractor, other property
		
		
* household related expenses
	gen cgk_household = cost if ///
		ucc==340914 | /// services for termite/pest control
		ucc==330511 | /// termite/pest control products
		ucc==340310 | /// housekeeping services
		ucc==340410 | /// gardening, lawn care service
		ucc==340901 | /// repairs/rentals of lawn and garden equipment, hand or power tools, other household equipment 
		ucc==340420 | /// water softening service
		ucc==340510 | /// moving, storage, freight
		ucc==340520 | /// household laundry and dry cleaning, sent out (nonclothing) not coin-operated
		ucc==340530 | /// coin-operated household laundry and dry cleaning (nonclothing)
		ucc==340620 | /// appliance repair, including service center
		ucc==340630 | /// reupholstering, furniture repair
		ucc==340903 | /// other home services
		ucc==340907 | /// appliance rentals
		ucc==340908 | /// rental of office equipment for nonbusiness use
		ucc==340915 | /// home security system service fee
		ucc==690113 | /// repair of computer systems for non-business use
		ucc==690114 | /// computer information services
		ucc==690310 | /// installation of computer
		ucc==990900   // rental and installation of dishwashers, range hoods, and garbage disposals
		
		
* rental expenditures (durables)
	gen cgk_rentexpD = cost if ///		
		ucc==240111	| /// paint wallpaper and supplies		/*maintenance and repair commodities*/
		ucc==240121	| /// tools and equipment for painting and wallpapering
		ucc==240211	| /// materials for plastering panels roofinggutters etc.
		ucc==240221	| /// materials for patio walk fence drivewaymasonry brick and stucco work
		ucc==240311	| /// plumbing supplies and equipment
		ucc==240321	| /// electrical supplies heating and cooling equipment
		ucc==320611	| /// material for insulation other maintenance and repair		/*miscellaneous supplies and equipment*/
		ucc==320621	| /// material for hard surface flooring
		ucc==320631	| /// material for landscape maintenance
		ucc==790690	| /// construction materials for jobs not started
		ucc==990920 | /// materials for additions, finishing basements, remodeling rooms
		ucc==990950   /// materials for dwellings under construction and additions Renter/under contruction/second home
		
		
* rental expenditures (services)
	gen cgk_rentexpS = cost if /// /*maintenance, insurance and other expense*/
		ucc==350110 | /// tenant's insurance
		ucc==230111 | /// repair or maintenance services renter
		ucc==230121 | /// repair or replacement of hard surfaced flooring renter
		ucc==230141 | /// repair of built-in appliances
		ucc==230150   // repair or maintenance services
		
		
* rent paid
	gen cgk_rentpaid = cost if /// 
		ucc==210110 // rent
		
		
* life insurance
	gen cgk_lifeins = cost if ///
		ucc==700110 | /// life, endowment, annuity, or other pesonal insurance
		ucc==2120     // other non-health insurance

		
* pensions 
	gen cgk_pensions = cost if 	/// pensions	pensions and social security
		ucc==800910	| /// deductions for government retirement
		ucc==800920	| /// deductions for railroad retirement
		ucc==800931	| /// deductions for private pensions
		ucc==800932	| /// non-payroll deposit to retirement plans
		ucc==800940	  // deductions for social security
		
		
* meals as payments
	gen cgk_mealspay = cost if ///
		ucc==800700 // meals as payments
		
		
* rent as payments
	gen cgk_rentpay = cost if /// 
		ucc==800710 // rent as pay
		
		
* occupational expenses
	gen cgk_occupexp = cost if /// 
		ucc==900002 // occupational expenditures (should be cautious about this one)
		
		
* property taxes
	gen cgk_proptax = cost if ///
		ucc==220211 | /// property taxes
		ucc==220212   // property taxes (vacation home)
		
		
* vehicle purchases (net outlay)
/*
 Note: 
  (1) "trade-in allowance"=A reduction in the price of a new item when an old item is given as part of the deal. 
  (2) Since the vehicle purchases are already 'net outlays' we do not have to substract the trade-in allowances.
*/
	gen cgk_vehpurch = cost if /// 
		ucc==450110 | /// new cars		/*new cars, trucks, and motorcycles*/
		ucc==450210 | /// new trucks
		ucc==450220 | /// new motorcycles
		ucc==460110 | /// used cars		/*used cars and trucks*/
		ucc==460901 | /// used trucks
		ucc==460902 | /// used motorcycles
		ucc==450900 | /// new aircraft		/*aircraft purchases*/
		ucc==460903   // used aircraft
		
		
* vehicle expenditures (durables)
	gen cgk_vehexpD = cost if ///		/*maintenance and repairs*/
		ucc==470220 | /// coolant, brake fluid, transmission fluid, and other additives
		ucc==480110 | /// tires - purchased, replaced, installed
		ucc==480211 | /// parts, equipment, accessories
		ucc==480212 | /// vehicle products and cleaning services
		ucc==480213 | /// parts, equipment, and accessories
		ucc==480214 | /// vehicle audio equipment
		ucc==480215   // vehicle audio equipment
		
		
* vehicle expenditures (services)
	gen cgk_vehexpS = cost if ///
		ucc==470311 | /// electric vehicle charging
		ucc==480216 | /// vehicle cleaning services including car wash
		ucc==490110 | /// body work and painting
		ucc==490211 | /// clutch and transmission repair
		ucc==490212 | /// drive shaft and rear-end repair
		ucc==490220 | /// brake work (old)
		ucc==490221 | /// brake work, including adjustments
		ucc==490231 | /// repair to steering or front-end
		ucc==490232 | /// repair to engine cooling system
		ucc==490300 | /// vehicle or engine repair
		ucc==490311 | /// motor tune-up
		ucc==490312 | /// lube, oil change, and oil filters
		ucc==490313 | /// front-end alignment, wheel balance and rotation
		ucc==490314 | /// shock absorber replacement
		ucc==490315 | /// brake adjustment (old)
		ucc==490317 | /// minor repairs and services out of town trips
		ucc==490318 | /// repair tires and other repair work
		ucc==490319 | /// vehicle air conditioning repair
		ucc==490411 | /// exhaust system repair
		ucc==490412 | /// electrical system repair
		ucc==490413 | /// motor repair, replacement
		ucc==490500	| /// purchase and installation of vehicle accessories (split 490501 and 490502)
		ucc==490501	| /// vehicle accessories including labor
		ucc==490502	| /// vehicle audio equipment including labor (thru Q20051)	
		ucc==490900	| /// auto repair service policy
		ucc==500110	| /// vehicle insurance
		ucc==510110	| /// automobile finance charges
		ucc==510901	| /// truck finance charges	
		ucc==510902	| /// motorcycle and plane f inance charges	*/
		ucc==850300	| /// other vehicle finance charges	*/
		ucc==520511	| /// auto rental	/*rented vehicles*/
		ucc==520512	| /// auto rental out-of-town trips	*/
		ucc==520521	| /// truck rental	*/
		ucc==520522	| /// truck rental out-of-town trips
		ucc==520902	| /// motorcycle rental
		ucc==520903	| /// aircraft rental
		ucc==520905	| /// motorcycle rental out-of-town trips
		ucc==520906	| /// aircraft rental, out of town trips (deleted 06)
		ucc==450310	| /// car lease payments		/*leased vehicles*/
		ucc==450311	| /// charges other than basic lease, such as insurance or maintenance (car lease)
		ucc==450313	| /// cash down-payment (car lease)		/*trade-in allowance (car lease) (deleted)*/
		ucc==450314	| /// termination fee (car lease)
		ucc==450410	| /// truck lease payments		/*trade-in allowance (truck/van lease) (deleted)*/
		ucc==450411	| /// charges other than basic lease (truck/van lease)
		ucc==450413	| /// cash down-payment (truck lease)
		ucc==450414	| /// termination fee (truck lease)
		ucc==520110	| /// state or local vehicle registration
		ucc==520111	| /// state vehicle registration (deleted 06)
		ucc==520112	| /// local vehicle registration (deleted 06)
		ucc==520310	| /// drivers' license
		ucc==520410	| /// vehicle inspection
		ucc==520530	| /// parking fees, incl. garages, meters, excl. costs of property ownership /*parking fees*/
		ucc==520531	| /// parking fees in home city excluding residence
		ucc==520532	| /// parking fees out-of-town trips
		ucc==520541	| /// tolls or electronic toll passes
		ucc==520542	| /// tolls on out-of-town trips
		ucc==520550	| /// towing charges
		ucc==520560	| /// global positioning services
		ucc==620113	  //
		
* miscellaneous expenditures (LA 2021)
	gen cgk_misc1 = cost if ///
		ucc==620112 | /// 
		ucc==620115 | ///
		ucc==620926 | ///
		ucc==680110 | ///
		ucc==680140 | ///
		ucc==680210 | ///
		ucc==680220 | ///
		ucc==680901 | ///
		ucc==680902 | ///
		ucc==790600 | ///
		ucc==880210 | ///
		ucc==900002 | ///
		ucc==680904 | ///
		ucc==710110
