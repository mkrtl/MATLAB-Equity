*****************************************************************
***** Integrating Lakner Milanovic database and WTID data *******
*****************************************************************

* In this file we combine Lakner Milanovic dataset to WTID data and construct 2013 estimates of a world income distribution
* Milanovic Lakner database use in "From the Berlin wall to the great recession", World Bank Economic Review, 2015
* Data provided by Milanovic Lakner in March 2015
* WTID data from www.topincomesdatabase.eu, latest update July 2015


* Step 1: Import and prepare LM data
* Step 2: Import and prepare WTID data
* Step 3: Combine WTID with LM data
* Step 4: Construct 2013 estimates
* Step 5: Convert data in PPP 2014
* Step 6: Misc operations

********************************************
***Step 1: Import and prepare LM data ******
********************************************

* Below we merge urban and rural surveys for India, CHN and Indonesia

clear all
use "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/lakner_milanovic_main.dta"
* NB: this file is available online, see Lakner and Milanovic WB economic review paper

** Some countries are missing in Lakner Milanovic, we approximate their inequality structure
* For Saudi Arabia and UAE, we use inequality structure of Colombia, in line with high inequality scenario (Alvaredo Piketty 2014)
append using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/SAUARE.dta"
* For Iran in 2008, we use Iran 2005 estimates
append using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/IRN.dta"



** Create D10 D9 D1 shares (used later to predict top1% shares)

* topten share
bysort contcod bin_year: egen a=total(RRinc)
gen b=100*RRinc/a if group==10
bysort country year: egen toptenmil=mean(b)
drop a b
* bottom ten share
bysort contcod bin_year: egen a=total(RRinc)
gen b=100*RRinc/a if group==1
bysort country year: egen bottomtenmil=mean(b)
drop a b
*  D9 share
bysort contcod bin_year: egen a=total(RRinc)
gen b=100*RRinc/a if group==9
bysort country year: egen D9mil=mean(b)
drop a b

** Merge urban and rural surveys for China India Indonesia to have more fractiles and delete the agregate/national level survey. 

* first, create urban rural indicator for China India Indonesia
gen urbru=.
replace urbru=1 if contcod=="CHN-U" | contcod=="IND-U" | contcod=="IDN-U"
replace urbru=2 if contcod=="CHN-R" | contcod=="IND-R" | contcod=="IDN-R"
replace contcod="CHN" if contcod=="CHN-U" | contcod=="CHN-R" 
replace contcod="IND" if contcod=="IND-U" | contcod=="IND-R" 
replace contcod="IDN" if contcod=="IDN-U" | contcod=="IDN-R" 

* recode groups for IND IDN CHN
sort country bin_year RRinc
foreach bin_year in 1988 1993 1998 2003 2008{
foreach var in IND CHN IDN{
egen `var'group`bin_year'=group(RRinc) if bin_year ==`bin_year' & contcod=="`var'" & urbru !=.
replace group=`var'group`bin_year' if bin_year == `bin_year' & contcod=="`var'" & urbru !=.
drop `var'group`bin_year'
}
}

* Store observations from national level survey in IND CHN IDN urban and rural components.
foreach bin_year in 1988 1993 1998 2003 2008{
foreach cont in IND CHN IDN{
foreach var in totpop RRmean cons_2005ppp_pc gdp_2005ppp_pc toptenmil bottomtenmil{
gen `var'`cont'`bin_year'a=`var' if bin_year==`bin_year' & contcod=="`cont'"  & urbru==.
egen `var'`cont'`bin_year'=mean(`var'`cont'`bin_year'a)
replace `var'=`var'`cont'`bin_year' if contcod=="`cont'" & bin_year==`bin_year' & urbru!=.
}
}
}

* drop 10 quantiles observation for IND CHN IDN (since we now have a more precise, 20 ventiles, representation)
drop if contcod=="IND" & urbru==.
drop if contcod=="IDN" & urbru==.
drop if contcod=="CHN" & urbru==.

* identify and mark the top quantile  (used later for IND IDN CHN which have 20 or 19 quantiles depending on years)
sort bin_year contcod group
gen topquantile=group[_n+1]-group[_n]
replace topquantile=0 if topquantile==1
replace topquantile=1 if topquantile<0
replace topquantile=1 if topquantile==.

* rename region variable (useful for later)
rename region regionmil



*clean
drop totpopIND1988a totpopIND1988 RRmeanIND1988a RRmeanIND1988 cons_2005ppp_pcIND1988a cons_2005ppp_pcIND1988 gdp_2005ppp_pcIND1988a gdp_2005ppp_pcIND1988 toptenmilIND1988a toptenmilIND1988 totpopCHN1988a totpopCHN1988 RRmeanCHN1988a RRmeanCHN1988 cons_2005ppp_pcCHN1988a cons_2005ppp_pcCHN1988 gdp_2005ppp_pcCHN1988a gdp_2005ppp_pcCHN1988 toptenmilCHN1988a toptenmilCHN1988 totpopIDN1988a totpopIDN1988 RRmeanIDN1988a RRmeanIDN1988 cons_2005ppp_pcIDN1988a cons_2005ppp_pcIDN1988 gdp_2005ppp_pcIDN1988a gdp_2005ppp_pcIDN1988 toptenmilIDN1988a toptenmilIDN1988 totpopIND1993a totpopIND1993 RRmeanIND1993a RRmeanIND1993 cons_2005ppp_pcIND1993a cons_2005ppp_pcIND1993 gdp_2005ppp_pcIND1993a gdp_2005ppp_pcIND1993 toptenmilIND1993a toptenmilIND1993 totpopCHN1993a totpopCHN1993 RRmeanCHN1993a RRmeanCHN1993 cons_2005ppp_pcCHN1993a cons_2005ppp_pcCHN1993 gdp_2005ppp_pcCHN1993a gdp_2005ppp_pcCHN1993 toptenmilCHN1993a toptenmilCHN1993 totpopIDN1993a totpopIDN1993 RRmeanIDN1993a RRmeanIDN1993 cons_2005ppp_pcIDN1993a cons_2005ppp_pcIDN1993 gdp_2005ppp_pcIDN1993a gdp_2005ppp_pcIDN1993 toptenmilIDN1993a toptenmilIDN1993 totpopIND1998a totpopIND1998 RRmeanIND1998a RRmeanIND1998 cons_2005ppp_pcIND1998a cons_2005ppp_pcIND1998 gdp_2005ppp_pcIND1998a gdp_2005ppp_pcIND1998 toptenmilIND1998a toptenmilIND1998 totpopCHN1998a totpopCHN1998 RRmeanCHN1998a RRmeanCHN1998 cons_2005ppp_pcCHN1998a cons_2005ppp_pcCHN1998 gdp_2005ppp_pcCHN1998a gdp_2005ppp_pcCHN1998 toptenmilCHN1998a toptenmilCHN1998 totpopIDN1998a totpopIDN1998 RRmeanIDN1998a RRmeanIDN1998 cons_2005ppp_pcIDN1998a cons_2005ppp_pcIDN1998 gdp_2005ppp_pcIDN1998a gdp_2005ppp_pcIDN1998 toptenmilIDN1998a toptenmilIDN1998 totpopIND2003a totpopIND2003 RRmeanIND2003a RRmeanIND2003 cons_2005ppp_pcIND2003a cons_2005ppp_pcIND2003 gdp_2005ppp_pcIND2003a gdp_2005ppp_pcIND2003 toptenmilIND2003a toptenmilIND2003 totpopCHN2003a totpopCHN2003 RRmeanCHN2003a RRmeanCHN2003 cons_2005ppp_pcCHN2003a cons_2005ppp_pcCHN2003 gdp_2005ppp_pcCHN2003a gdp_2005ppp_pcCHN2003 toptenmilCHN2003a toptenmilCHN2003 totpopIDN2003a totpopIDN2003 RRmeanIDN2003a RRmeanIDN2003 cons_2005ppp_pcIDN2003a cons_2005ppp_pcIDN2003 gdp_2005ppp_pcIDN2003a gdp_2005ppp_pcIDN2003 toptenmilIDN2003a toptenmilIDN2003 totpopIND2008a totpopIND2008 RRmeanIND2008a RRmeanIND2008 cons_2005ppp_pcIND2008a cons_2005ppp_pcIND2008 gdp_2005ppp_pcIND2008a gdp_2005ppp_pcIND2008 toptenmilIND2008a toptenmilIND2008 totpopCHN2008a totpopCHN2008 RRmeanCHN2008a RRmeanCHN2008 cons_2005ppp_pcCHN2008a cons_2005ppp_pcCHN2008 gdp_2005ppp_pcCHN2008a gdp_2005ppp_pcCHN2008 toptenmilCHN2008a toptenmilCHN2008 totpopIDN2008a totpopIDN2008 RRmeanIDN2008a RRmeanIDN2008 cons_2005ppp_pcIDN2008a cons_2005ppp_pcIDN2008 gdp_2005ppp_pcIDN2008a gdp_2005ppp_pcIDN2008 toptenmilIDN2008a toptenmilIDN2008
drop RRinc2 RRmean2 scale1RR scale2RR POSITION percentile ventile decile SURVEY_DATA


save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/lakner_milanovic_forWTID.dta", replace



********************************************
***Step 2: Import and prepare WTID data ****
********************************************
* Below we extract data from WTI database and put it in shape for combination with LM data.


clear all 
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTIDtop8614.xls"

rename A country
rename B year
rename C top10
rename D top10LAD
rename E top10couples
rename F top10adults
rename G top10tax
rename H top10IDS
rename I top5
rename J top5LAD
rename K top5couples
rename L top5adults
rename M top5tax
rename N top5IDS
rename O top1
rename P top1LAD
rename Q top1couples
rename R top1adults
rename S top1tax
rename T top1IDS

drop if [_n]<=2

* Chinese data is from HH survey, not tax data, so it is dropped
drop if country=="China"

destring year top10 top10LAD top10couples top10adults top10tax top10IDS top1 top1LAD top1couples top1adults top1tax top1IDS top5 top5LAD top5couples top5adults top5tax top5IDS, replace


* When top10 missing, assume it is equivalent to more specific top10 estimates
foreach var in top10IDS top10LAD top10couples top10adults top10tax  {
replace top10=`var' if top10==. & `var'!=.
}

* When top1 missing, assume it is equivalent to more specific top1 estimates
foreach var in top1LAD top1couples top1adults top1tax top1IDS {
replace top1=`var' if top1==. & `var'!=.
}

* When top1 missing, assume it is equivalent to more specific top5 estimates
foreach var in top5LAD top5couples top5adults top5tax top5IDS {
replace top5=`var' if top5==. & `var'!=.
}

* keep only top1 top5 and top10
drop top10LAD top10couples top10adults top10tax top10IDS top1LAD top1couples top1adults top1tax top1IDS top5LAD top5couples top5adults top5tax top5IDS

* In order to combine with Lakner Milanovic (and update it), we will only use 1988, 1993, 1998, 2003, 2008 years.
* When data from these year is not available we use assume that 2 years before or after can approximate it. 
* To do this we need to reshape wide

reshape wide top10 top5 top1, i(country) j(year)
 
* for top 1 variables

replace top11988=top11989 if top11988==.
replace top11988=top11987 if top11988==.
replace top11988=top11990 if top11988==.
replace top11988=top11986 if top11988==.

replace top11993=top11994 if top11993==.
replace top11993=top11992 if top11993==.
replace top11993=top11995 if top11993==.
replace top11993=top11991 if top11993==.

replace top11998=top11999 if top11998==.
replace top11998=top11997 if top11998==.
replace top11998=top12000 if top11998==.
replace top11998=top11996 if top11998==.

replace top12003=top12004 if top12003==.
replace top12003=top12002 if top12003==.
replace top12003=top12005 if top12003==.
replace top12003=top12001 if top12003==.

replace top12008=top12009 if top12008==.
replace top12008=top12007 if top12008==.
replace top12008=top12010 if top12008==.
replace top12008=top12006 if top12008==.

* ultimately for 2013, if there is no data, we use 2008 data (as it will be done below with survey incomes extrapolation).
replace top12013=top12014 if top12013==.
replace top12013=top12012 if top12013==.
replace top12013=top12011 if top12013==.
replace top12013=top12008 if top12013==.

* for top5
replace top51988=top51989 if top51988==.
replace top51988=top51987 if top51988==.
replace top51988=top51990 if top51988==.
replace top51988=top51986 if top51988==.

replace top51993=top51994 if top51993==.
replace top51993=top51992 if top51993==.
replace top51993=top51995 if top51993==.
replace top51993=top51991 if top51993==.

replace top51998=top51999 if top51998==.
replace top51998=top51997 if top51998==.
replace top51998=top52000 if top51998==.
replace top51998=top51996 if top51998==.

replace top52003=top52004 if top52003==.
replace top52003=top52002 if top52003==.
replace top52003=top52005 if top52003==.
replace top52003=top52001 if top52003==.

replace top52008=top52009 if top52008==.
replace top52008=top52007 if top52008==.
replace top52008=top52010 if top52008==.
replace top52008=top52006 if top52008==.

* ultimately for 2013, if there is no data, we use 2008 data (as it will be done below with survey incomes extrapolation).
replace top52013=top52014 if top52013==.
replace top52013=top52012 if top52013==.
replace top52013=top52011 if top52013==.
replace top52013=top52008 if top52013==.

* for top10
replace top101988=top101989 if top101988==.
replace top101988=top101987 if top101988==.
replace top101988=top101990 if top101988==.
replace top101988=top101986 if top101988==.

replace top101993=top101994 if top101993==.
replace top101993=top101992 if top101993==.
replace top101993=top101995 if top101993==.
replace top101993=top101991 if top101993==.

replace top101998=top101999 if top101998==.
replace top101998=top101997 if top101998==.
replace top101998=top102000 if top101998==.
replace top101998=top101996 if top101998==.

replace top102003=top102004 if top102003==.
replace top102003=top102002 if top102003==.
replace top102003=top102005 if top102003==.
replace top102003=top102001 if top102003==.

replace top102008=top102009 if top102008==.
replace top102008=top102007 if top102008==.
replace top102008=top102010 if top102008==.
replace top102008=top102006 if top102008==.

* ultimately for 2013, if there is no data, we use 2008 data (as it will be done below with survey incomes extrapolation).
replace top102013=top102014 if top102013==.
replace top102013=top102012 if top102013==.
replace top102013=top102011 if top102013==.
replace top102013=top102008 if top102013==.


keep country top11988 top11993 top11998 top12003 top12008 top12013 top101988 top101993 top101998 top102003 top102008 top102013 top51988 top51993 top51998 top52003 top52008 top52013

* reshape back to long format 
reshape long top1 top5 top10, i(country) j(bin_year)
rename top1 top1wtid
rename top5 top5wtid
rename top10 top10wtid

drop if top10wtid==. & bin_year==2013
drop if top5wtid==. & bin_year==2013
drop if top1wtid==. & bin_year==2013


* we now have a WTID file ready for combination with Lakner and Milanovic

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace

********************************************
***Step 3: combine WTID with LM data  ******
********************************************

clear all
use "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta"

joinby country bin_year using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/lakner_milanovic_forWTID.dta", unmatched(both)

drop if _merge==1 & bin_year!=2013


** Regress top1shares from WTID on Milanovic income distribution data

* Create a time indicator used for regression (on average, rise in top1shares over the years)
gen timevar=1
replace timevar=2 if bin_year>2002

* Regression to predict topshare on the basis of WTID data:
* We use top10% and bottom10% shares (from Milanovic) & and a time indicator to predict top1% share.
* NB: long format, use only one observation per country.
* NB: fit of regression is satisfactory, R2:0.55

reg top1wtid toptenmil bottomtenmil i.timevar if group==1

** Predict top1shares and use them in countries without WTID data
predict top1pred 
gen top1use=top1wtid
replace top1use=top1pred if top1use==.


gen popshare=pop/totpop

*clean
keep group cons_2005ppp_pc toptenmil RRinc RRmean bin_year year contcod country gdp_2005ppp_pc top1wtid top1use top1pred top5wtid top10wtid totpop pop popshare regionmil topquantile

* Now add (via append function) the reconstructed top shares
* NB: Below we only integrate top1 share

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace

keep if group==1 
replace group=100 if group==1

* Modify group population and popshare, by definition this is 1%   
replace popshare=0.01 if group==100
replace pop=popshare*totpop if group==100
append using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta"


*** Reconstruct top incomes

** Assume top1 is accounted for in the data but not correctly.
* Create its income on the basis of predicted top1 share and total income (from HFCE or GDP when HFCE not available)
replace cons_2005ppp_pc=gdp_2005ppp_pc if cons_2005ppp_pc==.
*drop country-years without HFCE or GDP data (Belarus, Slovenia and West Bank in 1988)
drop if cons_2005ppp_pc==. & bin_year!=2013

replace RRinc=cons_2005ppp_pc*totpop*top1use/(100*pop) if group==100

* Modify population of previous top10group, and compute its new pop share (90-99 for all countries except forCHN IDN and IND which become 9096 9097 or 9098 depending on survey-years)
tostring group, replace
gen toppopshare=round(100-(100*(pop/totpop))) if topquantile==1
gen toppopshare2=99
tostring toppopshare toppopshare2, replace
replace group=toppopshare+toppopshare2 if topquantile==1
drop toppopshare*

replace popshare=(pop/totpop)-0.01 if topquantile==1
replace pop=popshare*totpop if topquantile==1

* Income per capita within these next-to-top groups isn't modified
* We suppose that within previous top10, everybody had the same income (i.e. top1% has 1/10th of top10 income)
* Hence, new top9099 has a new *total* income (that would be: newgroupRRinc=0.9*pop*RRinc if group=="9099")
* But average per capita income (RRinc) is unchanged. 

** We now scale 1to99 fractiles to HFCE (at this step, only top 100% is in "HFCE base" - see above)
bys contcod bin_year: egen totinc199=total(RRinc*pop) if group!="100"
gen sharetot199=(RRinc*pop)/totinc199 if group!="100"
gen totalincomeHFCE199=(cons_2005ppp_pc*totpop)-(cons_2005ppp_pc*totpop*top1use/100)
replace RRinc=(totalincomeHFCE199*sharetot199)/pop if group!="100"

* verifications
*bys contcod bin_year: egen totalincome=total(RRinc*pop)
*gen sharegroup=RRinc*pop/totalincome
*gen sharegroup2=RRinc*pop/(cons_2005ppp_pc*totpop)
*bys contcod bin_year: egen sumtest=total(sharegroup)
*bys contcod bin_year: egen sumtest2=total(sharegroup2)

replace RRmean=cons_2005ppp_pc


label var RRmean "Mean income scaled to HFCE, 2005 PPP USD "
label var RRinc  "Group income scaled to HFCE,2005 PPP USD "



** Miscellaneous operations

gen sharegroup=(RRinc*pop)/(RRmean*totpop)

* Rounding variables to closest integer
foreach var in RRinc RRmean{
replace `var'=round(`var')
}
 

* Label vars
label var RRmean "Mean income scaled to HFCE, 2005 PPP USD "
label var RRinc  "Group income scaled to HFCE, 2005 PPP USD "

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace

****************************************************
*** Step 4: Construct year 2013 estimates **********
****************************************************


* Note: Income inequality data not available from surveys for this year and only few observations from WTID data. We assume same inequality structure in 2013 as in bin_year 2008 (except for few countries with WTID data in 2013). 
* keep only bin_year 2008 in a separate file on which we'll work
keep if bin_year==2008 
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013.dta", replace
clear all
use "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace
keep if bin_year==2013
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013only.dta", replace


** First update population data 
* Import population data from WB 
clear all
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/Population2013.xls"
foreach var of varlist A B C{
  rename `var' `=`var'[1]'
  }
drop if [_n]==1
destring Pop2013, replace
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/Population2013.dta", replace

* Drop countries without population data (these are v. small countries, v. small incidence on global coverage)
drop if Pop2013==.
replace Pop2013=Pop2013/1000000

* Combine with 2013 income file
joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013.dta", unmatched(using)
drop _merge
gen pop2008=pop
gen totpop2008=totpop
replace totpop=Pop2013
replace pop=popshare*totpop
drop if country==""
replace bin_year=2013

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013.dta", replace

** Then, update income variables
* We use WB per capita constant growth estimates to update 2008 data, not absolute values to ensure consistency with Lakner Milanovic database, his 2005ppp values are not exactly the same as the latest WB estimates. 

clear all
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/0813_HFCE_GDP_GROWTH.xls"

replace B="GDPgrowth" if B=="NY.GDP.PCAP.KD.ZG"
replace B="HFCEgrowth" if B=="NE.CON.PRVT.PC.KD.ZG"
drop if B==""
rename B series
rename C country
rename D contcod
rename E y2008
rename F y2009
rename G y2010
rename H y2011
rename I y2012
rename J y2013
drop A
drop if _n==1
destring y2008 y2009 y2010 y2011 y2012 y2013, replace
gen cumul=(1+(y2009/100))*(1+(y2010/100))*(1+(y2011/100))*(1+(y2012/100))*(1+(y2013/100))
keep series country contcod cumul
reshape wide cumul, i(contcod) j(series) string

* use GDPgrowth for HFCE when HFCE not available
replace cumulHFCEgrowth=cumulGDPgrowth if cumulHFCEgrowth==.

joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013.dta", unmatched (using)
drop _merge
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013.dta", replace

* Add 2013 top income data * NB we don't use 2013 WTID data to predict missing top income data, because of lack of predictors (these would be 2008 top10shares...)
append using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID2013only.dta"

* Update top income shares and incomes for countries with WTID data
gen top1wtid2013=top1wtid if bin_year==2013 & pop==. 
bysort country bin_year: egen top1wtid2=mean(top1wtid2013)
replace RRinc=top1wtid2*(RRmean*totpop)/(100*pop) if group=="100" & bin_year==2013 & top1wtid2!=.

* scale income variable to growth
gen groupshare=(RRinc*pop2008)/(totpop2008*RRmean)
replace RRmean=RRmean*cumulHFCEgrowth
replace RRinc=(RRmean*totpop)*groupshare/pop
replace cons_2005ppp_pc = cons_2005ppp_pc*cumulHFCEgrowth
replace gdp_2005ppp_pc = gdp_2005ppp_pc*cumulGDPgrowth


* Append with main file, we're back with all years from 1988 to 2013
append using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta"


** Clean
* drop data used to update top1shares
drop if RRinc==.

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace


**************************************************
***** Step 5 : Convert data in PPP 2014  *********
**************************************************


clear all


* Import and prepare WB data (to move from 2005 to 2014 PPPs)
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WBLCUdata.xls"

rename C country
rename D contcod
rename E y2005
rename F y2013
rename G y2014
drop if _n==1
drop if B==""
replace B="LCUpercurrentUSD_gdp" if B=="PA.NUS.PPP"
replace B="LCUper2005USD_cons" if B=="PA.NUS.PRVT.PP.05"
replace B="LCUper2005USD_gdp" if B=="PA.NUS.PPP.05"
replace B="LCUpercurrentUSD_cons" if B=="PA.NUS.PRVT.PP"
rename B series
drop A

destring y2005 y2013 y2014, replace
reshape wide y2005 y2013 y2014, i(contcod) j(series) string

drop y2013LCUper2005USD_cons y2014LCUper2005USD_cons y2013LCUper2005USD_gdp y2014LCUper2005USD_gdp


* Use private consumption LCU per intl $ when available, GDP LCU per intl $ when not
foreach var in 2005 2013 2014{
gen LCU_cons_current`var'=y`var'LCUpercurrentUSD_cons
replace LCU_cons_current`var'= y`var'LCUpercurrentUSD_gdp if LCU_cons_current`var'==.
rename y`var'LCUpercurrentUSD_gdp LCU_gdp_current`var'
}

rename y2005LCUper2005USD_cons LCU_cons_const2005
rename y2005LCUper2005USD_gdp LCU_gdp_const2005

drop y*

joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta"

save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace

clear all

* Import and prepare CPI data
import excel using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/CPIworld.xls"
keep B AU AV AW BC BD BE 
rename B contcod
rename AU CPI2004
rename AV CPI2005
rename AW CPI2006
rename BC CPI2012
rename BD CPI2013
rename BE CPI2014
drop if _n==1
drop if contcod==""
destring CPI*, replace

* For countries without CPI in 2005, 2013 or 2014, we use previous or next year data, when available
replace CPI2005=CPI2004 if CPI2005==.
replace CPI2005=CPI2006 if CPI2005==.
replace CPI2013=CPI2012 if CPI2013==.
replace CPI2013=CPI2014 if CPI2013==.
replace CPI2014=CPI2013 if CPI2014==.


drop CPI2004 CPI2006 CPI2012

* Combine CPI data with 88-2013 income dataset
joinby contcod using "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", unmatched (using)

* Transform data from PPP to 2005 LCU  
replace RRinc=RRinc*LCU_cons_const2005
replace RRmean=RRmean* LCU_cons_const2005
replace cons_2005ppp_pc=cons_2005ppp_pc*LCU_cons_const2005
replace gdp_2005ppp_pc= gdp_2005ppp_pc*LCU_gdp_const2005

* Transform data from LCU 2005 to 2014 LCU 
replace RRinc=(RRinc/CPI2005)*CPI2014 
replace RRmean=(RRmean/CPI2005)*CPI2014 
replace cons_2005ppp_pc=(cons_2005ppp_pc/CPI2005)*CPI2014 
replace gdp_2005ppp_pc= (gdp_2005ppp_pc/CPI2005)*CPI2014 


* All data in 2014 LCU

* Transform data in 2014 PPP$
replace RRinc=RRinc/LCU_cons_current2014
replace RRmean=RRmean/LCU_cons_current2014
replace cons_2005ppp_pc=cons_2005ppp_pc/LCU_cons_current2014
replace gdp_2005ppp_pc= gdp_2005ppp_pc/LCU_gdp_current2014

** Convert 2014 PPP$ in 2014 Ûuros
* NB: EUR USD PPP parity at 1.22 in 2014 (OECD PPP tables for private consumption)
replace RRinc=RRinc/1.22
replace RRmean=RRmean/1.22
replace cons_2005ppp_pc=cons_2005ppp_pc/1.22
replace gdp_2005ppp_pc= gdp_2005ppp_pc/1.22

rename cons_2005ppp_pc cons_EUR2014ppp_pc
rename gdp_2005ppp_pc gdp_EUR2014ppp_pc



label variable RRinc "Real group income in EURO PPP 2014 "
label variable RRmean "Mean per capita income EURO PPP 2014 "


* Cleaning
* Country without CPI data= ARG CHL FSM TKM UZB VEN
drop if RRinc==.
drop CPI* _merge LCU* Pop2013
* absurd value for LTU mean income (wrong LCU conversion)
drop if contcod=="LTU"


*/

**********************************
*** Step 6: Misc operations ******
**********************************


* generating percentiles of world income distribution

gen percentile=.
foreach bin_year in 1988 1993 1998 2003 2008 2013{ 
xtile percentile`bin_year'=RRinc [aw=pop] if bin_year==`bin_year', nq(100)
replace percentile=percentile`bin_year' if bin_year==`bin_year'
}

gen cinquantile=.
foreach bin_year in 1988 1993 1998 2003 2008 2013{ 
xtile cinquantile`bin_year'=RRinc [aw=pop] if bin_year==`bin_year', nq(100)
replace cinquantile=cinquantile`bin_year' if bin_year==`bin_year'
}

gen ventile=.
foreach bin_year in 1988 1993 1998 2003 2008 2013{ 
xtile ventile`bin_year'=RRinc [aw=pop] if bin_year==`bin_year', nq(20)
replace ventile=ventile`bin_year' if bin_year==`bin_year'
}

* regions

drop region
gen region=""
foreach var in AUT BEL BGR CYP CZE DNK EST FIN FRA DEU GRC HUN HRV ISL IRL ITA LVA LTU LUX NLD NOR POL PRT ROU SVK SVN ESP SWE CHE GBR ROM{
replace region="EU" if contcod=="`var'"
}
foreach var in USA CAN{
replace region="North America" if contcod=="`var'"
}
replace region="China" if contcod=="CHN" | contcod=="HKG"
replace region="India" if contcod=="IND"
foreach var in BGD BTN KHM FJI IDN IDN LAO MYS MNG NPL PAK PHL LKA THA TLS VNM PNG MDV KOR TWN SGP{
replace region="Other Asia" if contcod=="`var'"
}
foreach var in EGY IRQ JOR MAR YEM DZA IRN SYR TUN ARE SAU ISR TUR{
replace region="Mid.East/N.A" if contcod=="`var'"
}
foreach var in AGO BFA BDI BEN BWA CPV CMR CAF COD COM COG SEN SLE CIV DJI GIN KEN LBR MDG MWI MLI MRT LSO MOZ NAM NER NGA RWA SYC TCD TMP ZAF SDN STP SWZ TZA TGO UGA ZMB ETH GAB GMB GHA GNB ZAR ZWE{
replace region="S.S.Africa" if contcod=="`var'"
}
foreach var in ARG BOL BRA BRB BLZ CHL COL CRI DOM ECU SLV GTM HND LCA MEX NIC PAN PRY PER URY VEN GUY HTI JAM SUR TTO{
replace region="Latin America" if contcod=="`var'"
}
foreach var in ALB ARM AZE BLR BIH GEO KGZ MKD MNE RUS SRB TJK UKR KAZ MDA TKM UZB{
replace region="Russia/C.Asia" if contcod=="`var'"
}
foreach var in JPN AUS NZL{
replace region="OtherRich" if contcod=="`var'"
}


*Cleaning
drop percentile1* percentile2* ventile1* ventile2*


* Dataset is ready 
sort bin_year RRinc
save "/Users/ilucas/Dropbox/Wincard/WorldCO2distribution/Income/WTID8813.dta", replace
