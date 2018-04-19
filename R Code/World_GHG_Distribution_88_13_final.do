*****************************************************************
***** Integrating income data with CO2/GHG data *****************
*****************************************************************

* In this file we combine WTID/Lakner Milanovic data with CO2 and GHG estimates
* Income data from WTID(2015) and Lakner Milanovic(2015)
* GHG data from CAIT(2015), retrieved in Sept 2015 and CICERO-GTAP, provided by Glenn Peters and Robby Andrew in March 2015

* Step 1: Import and prepare CO2 and GHG emisions data
* Step 2: Attribute emissions to income groups
* Step 3: Release single elasticity assumption 
* Step 4: Create world emissions fractiles


*****************************************************************
***** Step 1: Import and prepare CO2 and GHG emisions data ******
*****************************************************************
* Three types of emissions are imported step by step: CO2 (production) GHG (production) GHG (consumption)

clear all
use "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_CAIT_EDGAR.dta"
replace GHG_CAIT=GHG_CAIT*1000
rename GHG_CAIT GHG 
keep contcod bin_year GHG
keep if bin_year==1990 |bin_year==1993 | bin_year==1997| bin_year==1998 | bin_year==2003 | bin_year==2007 | bin_year==2008 | bin_year==2012
* create 1988 bin_year (used later)
replace bin_year=1988 if bin_year==1990
replace GHG=. if bin_year==1988
* assume 2012 is same as 2013 (2012 latest year in CAIT for all countries)
replace bin_year=2013 if bin_year==2012
reshape wide GHG,i(contcod) j(bin_year)

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/world_GHG_CAIT.dta", replace



* Import and prepare GHG GTAP 1997 file

clear all
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/cons1997.xls"

* rename variables
rename A country 
rename B GHG_GTAP_1997
rename C GHG_GTAP_prod_1997

* Combine with population file

joinby country using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/country97withpop.dta", unmatched (both)

sort _merge region

* Clean the data: below, some countries without proper country codes

drop if sharepop==0
drop if country==""
gen Tanzania=.
replace Tanzania=GHG_GTAP_1997 if country=="Tanzania"
egen Tanzania2=max(Tanzania)
replace GHG_GTAP_1997=Tanzania2 if contcod=="TZA"
drop Tanzania Tanzania2
gen Korea=.
replace Korea=GHG_GTAP_1997 if country=="Korea"
egen Korea2=max(Korea)
replace GHG_GTAP_1997=Korea2 if contcod=="KOR"
drop Korea Korea2
gen USA=.
replace USA=GHG_GTAP_1997 if country=="United States"
egen USA2=max(USA)
replace GHG_GTAP_1997=USA2 if contcod=="USA"
drop USA USA2

gen Tanzania=.
replace Tanzania=GHG_GTAP_1997 if country=="Tanzania"
egen Tanzania2=max(Tanzania)
replace GHG_GTAP_1997=Tanzania2 if contcod=="TZA"
drop Tanzania Tanzania2
gen Korea=.
replace Korea=GHG_GTAP_1997 if country=="Korea"
egen Korea2=max(Korea)
replace GHG_GTAP_1997=Korea2 if contcod=="KOR"
drop Korea Korea2
gen USA=.
replace USA=GHG_GTAP_1997 if country=="United States"
egen USA2=max(USA)
replace GHG_GTAP_1997=USA2 if contcod=="USA"
drop USA USA2

gen Tanzania=.
replace Tanzania=GHG_GTAP_prod_1997 if country=="Tanzania"
egen Tanzania2=max(Tanzania)
replace GHG_GTAP_prod_1997=Tanzania2 if contcod=="TZA"
drop Tanzania Tanzania2
gen Korea=.
replace Korea=GHG_GTAP_prod_1997 if country=="Korea"
egen Korea2=max(Korea)
replace GHG_GTAP_prod_1997=Korea2 if contcod=="KOR"
drop Korea Korea2
gen USA=.
replace USA=GHG_GTAP_prod_1997 if country=="United States"
egen USA2=max(USA)
replace GHG_GTAP_prod_1997=USA2 if contcod=="USA"
drop USA USA2

* NB: countries below are not dropped (we keep relevant contcods but drop observations with misleading country name)
drop if country=="United States"
drop if country=="Korea"
drop if country=="Tanzania"


rename _merge _merge2
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/cons1997.dta", replace


* Assigning regional codes to observations
replace contcod="XSU" if country=="Rest of Former Soviet Union"
replace contcod="XSS" if country=="Rest of Sub Saharan Africa"
replace contcod="XSM" if country=="Rest of South America"
replace contcod="XSF" if country=="Other Southern Africa"
replace contcod="XSC" if country=="Rest of South African Customs Union"
replace contcod="XSA" if country=="Rest of South Asia"
replace contcod="XRW" if country=="Rest of World"
replace contcod="XNF" if country=="Rest of North Africa"
replace contcod="XME" if country=="Rest of Middle East"
replace contcod="XEF" if country=="Rest of EFTA"
replace contcod="XCM" if country=="Central America and the Caribbean"
replace contcod="XCE" if country=="Rest of Central European Associates"
replace contcod="XAP" if country=="Rest of Andean Pact"
replace region=contcod if region=="ALB" 

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/cons1997.dta", replace

joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/world_GHG_CAIT.dta", unmatched(both)


drop if _merge==2

* Create emissions share within regional group

bysort region: gen sumghg=sum(GHG1997)
bysort region: egen ghgregion=max(sumghg)

gen shareghg=100*GHG1997/ghgregion

gen GHG_GTAP_1997_gbase= GHG_GTAP_1997
gen GHG_GTAP_prod_1997_gbase= GHG_GTAP_prod_1997


* Reconstructing country GHG emissions for countries without observations (i.e. countries which are part of the 7 regions mentioned below)
* Here, since we have no further information, we simply distribute GHG emissions to a country of region proportionnaly to its population in the region, 
* That is= emissions_country_c=total_emissions_region*pop_country_c/total_pop_region
* Assumption here is that countries of the same region have the same per capita GHG emissions. 
* NB: countries concerned represent only 13% of global GHG emissions, for the rest we have detailed national level data). 

foreach var in XSU XSS XSM XSF XSC XSA XRW XNF XME XEF XCM XCE XAP{
gen `var'=.
gen `var'prod=.
replace `var'=GHG_GTAP_1997 if contcod=="`var'"
replace `var'prod=GHG_GTAP_prod_1997 if contcod=="`var'"
egen `var'2=max(`var')
egen `var'2prod=max(`var'prod)
drop `var' `var'prod
replace GHG_GTAP_1997=`var'2*sharepop/100 if region=="`var'"
replace GHG_GTAP_prod_1997=`var'2prod*sharepop/100 if region=="`var'"
replace GHG_GTAP_1997_gbase=`var'2*shareghg/100 if region=="`var'"
replace GHG_GTAP_prod_1997_gbase=`var'2prod*shareghg/100 if region=="`var'"
}

gen ghgcap=GHG1997/(1000*totpop)
gen ghgcap_pbase= GHG_GTAP_1997/(1000*totpop)
gen ghgcap_gbase= GHG_GTAP_1997_gbase/(1000*totpop)
gen ghgcap_prod_gbase= GHG_GTAP_prod_1997_gbase/(1000*totpop)
gen ratio=ghgcap_gbase/ghgcap_pbase


gen ghg_1997_cons= GHG_GTAP_1997
gen ghg_1997_prod= GHG_GTAP_prod_1997

drop if ghg_1997_cons ==.
rename region region97
keep contcod country region97 ghg_1997_cons ghg_1997_prod
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_GTAP_1997.dta",replace


* Import and prepare GHG GTAP 2007 file

clear all
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_GTAP_2007.xls"
foreach var of varlist A B C D E {
  rename `var' `=`var'[1]'
  }
drop if [_n]==1
drop F G H I
rename gtap_region region 
destring ghg_2007_cons, replace
destring ghg_2007_prod, replace
drop if _n>156
 
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_GTAP_2007.dta",replace
 
drop if country==""
joinby contcod using  "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/world_GHG_CAIT.dta", unmatched(both)
drop if _merge==2
rename _merge _merge1

* combining with population file to derive per capita means
joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/worldpop08.dta", unmatched (both)


* computing emissions totals and population shares per region, operation used for step below
bysort region: egen ghgregion=total(GHG2007)
gen shareghg=100*GHG2007/ghgregion
  
bysort region: egen popregion=total(totpop)
gen sharepop=100*totpop/popregion

drop if popregion==0
drop _merge _merge1

gen GHG_GTAP_2007_gbase= ghg_2007_cons
gen GHG_GTAP_prod_2007_gbase= ghg_2007_prod
gen GHG_GTAP_2007_pbase= ghg_2007_cons
gen GHG_GTAP_prod_2007_pbase= ghg_2007_prod


* Reconstructing country GHG emissions for countries without observations (i.e. countries which are part of the 7 aggregate regions mentioned below)
* Here, since we have no further information, we simply distribute GHG emissions to a country of region proportionnaly to its population in the region, 
* That is= emissions_country_c=total_emissions_region*pop_country_c/total_pop_region
* Assumption here is that countries of the same region have the same per capita GHG emissions. 
* NB: these countries represent only 5% of total emissions!
* NB: we also do the same using GHG emissions share from CAIT data (instead of population share) - but prefer population shares

foreach var in XAC XEC XER XNF XSU XWF XWS{
gen `var'=.
gen `var'prod=.
replace `var'= ghg_2007_cons if contcod=="`var'"
replace `var'prod= ghg_2007_prod if contcod=="`var'"
egen `var'2=max(`var')
egen `var'2prod=max(`var'prod)
drop `var' `var'prod
replace GHG_GTAP_2007_pbase =`var'2*sharepop/100 if region=="`var'"
replace GHG_GTAP_prod_2007_pbase=`var'2prod*sharepop/100 if region=="`var'"
replace GHG_GTAP_2007_gbase=`var'2*shareghg/100 if region=="`var'"
replace GHG_GTAP_prod_2007_gbase=`var'2prod*shareghg/100 if region=="`var'"
}

* cleaning 
drop if totpop==.
drop if GHG_GTAP_2007_gbase==.
replace ghg_2007_cons=GHG_GTAP_2007_pbase
replace ghg_2007_prod= GHG_GTAP_prod_2007_pbase
keep contcod region ghg_2007_cons ghg_2007_prod

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_GTAP_2007.dta", replace

* combine the two datasets
joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/GHG_GTAP_1997.dta"
joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/world_GHG_CAIT.dta"

* rename variable
rename ghg_2007_cons GHG_cons2008
rename ghg_2007_prod GHG_prod2008
rename ghg_1997_cons GHG_cons1998
rename ghg_1997_prod GHG_prod1998


*reshape back to long format
*CYP appears twice, it is dropped
drop if contcod=="CYP"

reshape long GHG GHG_prod GHG_cons, i(contcod) j(bin_year)
rename region region07

* Updating consumption GHG emissions for years 2003 and 2013

* 1st approximation method, we adjust 2003 and 2013 CAIT emissions using 1998 and 2008 GHG CAI/GHG consumption ratios and knowing CAIT 2003 and 2013 emissions
* In other words, we assume that the structure of CO2 trade is relatively similar between 1998 and 2003, 2008 and 2013; but we adjust for the growth in global emissions.

* For 2003


gen ratioGHG98prod=.
gen ratioGHG98cons=.
replace ratioGHG98prod=GHG/GHG_prod if bin_year==1998
replace ratioGHG98cons=GHG/GHG_cons if bin_year==1998
bysort country: egen ratioGHG98prod2= mean(ratioGHG98prod)
bysort country: egen ratioGHG98cons2= mean(ratioGHG98cons)
drop ratioGHG98prod ratioGHG98cons


replace GHG_prod=GHG/ratioGHG98prod2 if bin_year==2003
replace GHG_cons=GHG/ratioGHG98cons2 if bin_year== 2003

* Checking % covered for 1998 and 2003

egen totalGHG98=total(GHG) if bin_year==1998
egen totalGHG_cons98=total(GHG_cons) if bin_year==1998
egen totalGHG98a= mean(totalGHG98)
egen totalGHG_cons98a= mean(totalGHG_cons98)
gen  ratioGHG98=totalGHG_cons98a/totalGHG98a
disp ratioGHG98

egen totalGHG03=total(GHG) if bin_year== 2003
egen totalGHG_cons03=total(GHG_cons) if bin_year== 2003
egen totalGHG03a= mean(totalGHG03)
egen totalGHG_cons03a= mean(totalGHG_cons03)
gen  ratioGHG03=totalGHG_cons03a/totalGHG03a
disp ratioGHG03

* For 2013

gen ratioGHG08prod=.
gen ratioGHG08cons=.
replace ratioGHG08prod=GHG/GHG_prod if bin_year==2008
replace ratioGHG08cons=GHG/GHG_cons if bin_year==2008
bysort country: egen ratioGHG08prod2= mean(ratioGHG08prod)
bysort country: egen ratioGHG08cons2= mean(ratioGHG08cons)
drop ratioGHG08prod ratioGHG08cons


replace GHG_prod=GHG/ratioGHG08prod2 if bin_year==2013
replace GHG_cons=GHG/ratioGHG08cons2 if bin_year== 2013

* Checking % covered for 2008 and 2013

egen totalGHG08=total(GHG) if bin_year==2008
egen totalGHG_cons08=total(GHG_cons) if bin_year==2008
egen totalGHG08a= mean(totalGHG08)
egen totalGHG_cons08a= mean(totalGHG_cons08)
gen  ratioGHG08=totalGHG_cons08a/totalGHG08a
disp ratioGHG08

egen totalGHG13=total(GHG) if bin_year== 2013
egen totalGHG_cons13=total(GHG_cons) if bin_year== 2013
egen totalGHG13a= mean(totalGHG13)
egen totalGHG_cons13a= mean(totalGHG_cons13)
gen  ratioGHG13=totalGHG_cons13a/totalGHG13a
disp ratioGHG13



save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/CAIT_GHG_CO2_GTAP.dta", replace

*******************************************************************
***** Step 2: Attribute CO2 emissions to different income groups **
*******************************************************************

** We have three types of emissions to attribute to income groups
* CO2 emissions (production base) from CAIT
* GHG emissions (consumption base) from CICERO
* GHG emissions (production base) from CICERO


** Method followed to attribute emissions to income groups: constant elasticity assumption
* CO2 emissions attributed to income groups as follows
* CO2_i=f_i.(CO2tot/S).y_i^e
* where
* f_i = share of group i in total population
* y_i = mean income in group i
* CO2tot= total emissions in the country 
* S= [sum(i=1 to N) (f_i.y_i^(e))]]
* e =  income/CO2 elasticity
* per capita CO2 emissions are then= CO2_i/pop_i

** For each type of emissions (CO2, GHG consumption, GHG production) we use elasticity values from 0.6 to 1.1 to cover a wide range of possibilities
* Method is thus repeated 3*6=18 times, creating 18 emissions variables per income group


*joinby with income inequality dataset 
joinby contcod bin_year using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta"


** First, check per capita mean GHG emissions country by country
gen GHGcap_cait=GHG/(1000*totpop)
gen GHGcap_cons_gtap=GHG_cons/(1000*totpop)
gen GHGcap_prod_gtap=GHG_prod/(1000*totpop)
*keep if bin_year==1998 | bin_year==2008 | bin_year==2013
*keep if group==2
*sort bin_year GHGcap_cons_gtap
*br country GHGcap_cons_gtap GHG GHGcap_cait CO2cap_cait GHGcap_prod_gtap RRmean bin_year



*** CONSUMPTION BASE GHG EMISSIONS ***

******************
* elasticity 0.6 *
******************

*multiply income by elasticity
gen GHG_conscap_06=(RRinc^(0.6))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_06 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_06)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_06=GHG_conscap_06*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_06=GHG_conscap_06/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_06*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted
mean GHG_conscap_06 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.7 *
******************


*multiply income by elasticity
gen GHG_conscap_07=(RRinc^(0.7))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_07 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_07)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_07=GHG_conscap_07*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_07=GHG_conscap_07/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_07*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_07 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.8 *
******************


*multiply income by elasticity
gen GHG_conscap_08=(RRinc^(0.8))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_08 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_08)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_08=GHG_conscap_08*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_08=GHG_conscap_08/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_08*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_08 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.9 *
******************


*multiply income by elasticity
gen GHG_conscap_09=(RRinc^(0.9))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_09 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_09)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_09=GHG_conscap_09*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_09=GHG_conscap_09/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_09*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_09 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

****************
* elasticity 1 *
****************


*multiply income by elasticity
gen GHG_conscap_1=(RRinc^(1))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_1 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_1)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_1=GHG_conscap_1*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_1=GHG_conscap_1/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_1*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_1 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

****************
* elasticity 1.1 *
****************


*multiply income by elasticity
gen GHG_conscap_11=(RRinc^(1.1))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_11 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_11)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_11=GHG_conscap_11*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_11=GHG_conscap_11/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_11*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_11 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

****************
* elasticity 1.5 *
****************


*multiply income by elasticity
gen GHG_conscap_15=(RRinc^(1.5))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_cons total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_cons: sum of GHG_conscap_15 for each country 
by contcod bin_year: replace sumint=sum(GHG_conscap_15)
by contcod bin_year: egen sumGHG_cons=max(sumint)
replace GHG_conscap_15=GHG_conscap_15*GHG_cons/sumGHG_cons
* GHG_cons per capita
replace GHG_conscap_15=GHG_conscap_15/(1000*pop)
drop sumGHG_cons sumint

*checking GHG_cons allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_conscap_15*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_cons-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_conscap_15 [aw=pop] if bin_year==2008
  
drop check1 check2 check3


*** PRODUCTION BASE GHG EMISSIONS ***

******************
* elasticity 0.6 *
******************

*multiply income by elasticity
gen GHG_prodcap_06=(RRinc^(0.6))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_06 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_06)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_06=GHG_prodcap_06*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_06=GHG_prodcap_06/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_06*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted
mean GHG_prodcap_06 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.7 *
******************


*multiply income by elasticity
gen GHG_prodcap_07=(RRinc^(0.7))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_07 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_07)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_07=GHG_prodcap_07*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_07=GHG_prodcap_07/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_07*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_prodcap_07 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.8 *
******************


*multiply income by elasticity
gen GHG_prodcap_08=(RRinc^(0.8))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_08 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_08)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_08=GHG_prodcap_08*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_08=GHG_prodcap_08/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_08*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_prodcap_08 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

******************
* elasticity 0.9 *
******************


*multiply income by elasticity
gen GHG_prodcap_09=(RRinc^(0.9))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_09 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_09)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_09=GHG_prodcap_09*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_09=GHG_prodcap_09/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_09*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_prodcap_09 [aw=pop] if bin_year==2008
  
drop check1 check2 check3

****************
* elasticity 1 *
****************


*multiply income by elasticity
gen GHG_prodcap_1=(RRinc^(1))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_1 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_1)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_1=GHG_prodcap_1*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_1=GHG_prodcap_1/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_1*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_prodcap_1 [aw=pop] if bin_year==2008
  
drop check1 check2 check3


****************
* elasticity 1.1 *
****************


*multiply income by elasticity
gen GHG_prodcap_11=(RRinc^(1.1))*(pop/totpop)
*generate country specific variable to scale new distribution to GHG_prod total
gen sumint=0
sort contcod bin_year
*create variable sumGHG_prod: sum of GHG_prodcap_11 for each country 
by contcod bin_year: replace sumint=sum(GHG_prodcap_11)
by contcod bin_year: egen sumGHG_prod=max(sumint)
replace GHG_prodcap_11=GHG_prodcap_11*GHG_prod/sumGHG_prod
* GHG_prod per capita
replace GHG_prodcap_11=GHG_prodcap_11/(1000*pop)
drop sumGHG_prod sumint

*checking GHG_prod allocation procedure (ok if check3=0)
sort contcod bin_year
by contcod bin_year: gen check1=sum(GHG_prodcap_11*pop*1000)
by contcod bin_year: egen check2=max(check1)
by contcod bin_year: gen check3=GHG_prod-(check2)
sum check3 if RRinc~=.,d

* check per capita means, weight-adjusted

mean GHG_prodcap_11 [aw=pop] if bin_year==2008
drop check1 check2 check3


** clean
* dropping IRQ (no GHG obs)
drop if contcod=="IRQ"


*****************************************************
*** Step 3: Release single elasticity assumption **** 
*****************************************************

* We modify certain elasticity values based on recent publications. 
* This also allows to test for the robusteness of our assumptions.


gen elasticity_value=0
replace elasticity=8 if contcod=="USA" | contcod=="CHN" | contcod=="CAN"
replace elasticity=11 if contcod=="BRA" | contcod=="IND"

gen mixed_elasticities=GHG_conscap_09
replace mixed_elasticities=GHG_conscap_07 if elasticity==7
replace mixed_elasticities=GHG_conscap_08 if elasticity==8
replace mixed_elasticities=GHG_conscap_11 if elasticity==11




***************************************************
*** Step 4: Create world emissions fractiles  *****
***************************************************


* generate fractiles for each year - on consumption base emissions
gen percentileGHG=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile percentileGHG`bin_year'=GHG_conscap_09 [aw=pop] if bin_year==`bin_year', nq(100)
replace percentileGHG=percentileGHG`bin_year' if bin_year==`bin_year'
}


gen cinquantileGHG=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile cinquantileGHG`bin_year'=GHG_conscap_09 [aw=pop] if bin_year==`bin_year', nq(50)
replace cinquantileGHG=cinquantileGHG`bin_year' if bin_year==`bin_year'
}

gen ventileGHG=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile ventileGHG`bin_year'=GHG_conscap_09 [aw=pop] if bin_year==`bin_year', nq(20)
replace ventileGHG=ventileGHG`bin_year' if bin_year==`bin_year'
}


* generate fractiles for each year - on production base emissions

gen percentileGHG_prod=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile percentileGHG`bin_year'_prod=GHG_prodcap_09 [aw=pop] if bin_year==`bin_year', nq(100)
replace percentileGHG_prod=percentileGHG`bin_year'_prod if bin_year==`bin_year'
}


gen cinquantileGHG_prod=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile cinquantileGHG`bin_year'_prod=GHG_prodcap_09 [aw=pop] if bin_year==`bin_year', nq(50)
replace cinquantileGHG_prod=cinquantileGHG`bin_year'_prod if bin_year==`bin_year'
}

gen ventileGHG_prod=.
foreach bin_year in 1998 2003 2008 2013{ 
xtile ventileGHG`bin_year'_prod=GHG_prodcap_09 [aw=pop] if bin_year==`bin_year', nq(20)
replace ventileGHG_prod=ventileGHG`bin_year'_prod if bin_year==`bin_year'
}


/* Each country-fractile-year prior to 2013 is associated its world position in 2013 (used for quasi-non-anonymous Growth Incidence Curves - see figures folder).  

gen percentile2013=.
foreach var in ALB ARM AUT AZE BDI BEL BFA BGD BGR BOL BRA CAN CHE CIV CMR COL CRI CZE DEU DNK DOM ECU EGY ESP EST FIN FRA GBR GEO GIN GRC GTM HND HRV HUN IRL ISR ITA JOR JPN KEN KGZ KHM KOR LBR LKA LTU LUX LVA MAR MDG MEX MLI MNG MOZ MRT MWI MYS NER NGA NIC NLD NOR NPL PAK PAN PER PHL POL PRT PRY RUS RWA SDN SGP SLV SVK SVN SWE THA TJK TUR TZA UGA UKR URY USA VNM ZAF ZMB{
foreach n in 1 2 3 4 5 6 7 8 9099 100 {
gen pct`var'`n'=.
replace pct`var'`n'=percentileGHG if contcod=="`var'" & group==`n' & bin_year==2013
egen pct2`var'`n'=mean(pct`var'`n')
replace percentile2013 =pct2`var'`n' if contcod=="`var'" & group==`n' & bin_year==1998
}
}


drop pct* pct2* 

foreach var in IND IDN CHN{
foreach n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 100 {
gen pct`var'`n'=.
replace pct`var'`n'=percentileGHG if contcod=="`var'" & group==`n' & bin_year==2013
egen pct2`var'`n'=mean(pct`var'`n')
replace percentile2013 =pct2`var'`n' if contcod=="`var'" & group==`n' & bin_year==1998
}
}

replace percentile2013=percentileGHG if bin_year==2013

drop pct* pct2* 
*/
sort bin_year GHG_conscap_09

* keep variables of interest
keep contcod bin_year country GHG GHG_prod GHG_cons totpop pop group RRinc RRmean region GHG_conscap_06 GHG_conscap_07 GHG_conscap_08 GHG_conscap_09 GHG_conscap_1 GHG_conscap_11 GHG_conscap_15 GHG_prodcap_06 GHG_prodcap_07 GHG_prodcap_08 GHG_prodcap_09 GHG_prodcap_1 GHG_prodcap_11


save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/CO2/World_GHG_Distribution_88_13.dta", replace

