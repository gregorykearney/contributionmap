//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Alabama Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Alabama/Alabama Education GASB Data.xlsx", firstrow

drop if Year ==.
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Alabama ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Alabama/2015-2022 GASB 68 & NCES Alabama File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Alaska Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Alaska/Alaska Education GASB Data.xlsx", firstrow

drop if Year ==2023
drop if LEAID ==""
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Alaska ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Alaska/2015-2022 GASB 68 & NCES Alaska File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Arizona Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Arizona/Arizona GASB 68 Education Data.xlsx", sheet("Sheet1") firstrow

drop if LEAID =="0"
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


foreach var of varlist district_contribution total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Arizona ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if dc_share_schools < 0
drop if dc_share_schools > 1

egen count = count(LEAID), by(LEAID)

keep if count ==8

preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Arizona/2015-2022 GASB 68 & NCES Arizona File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Arkansas Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Arkansas/Arkansas Education GASB Data (STATA).xlsx", sheet("Final Data") firstrow


drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}



drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G

//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Arkansas ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win)

drop if dc_share_schools <= 0
drop if dc_share_schools > 88

egen count = count(LEAID), by(LEAID)

keep if count ==8

preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Arkansas/2015-2022 GASB 68 & NCES Arkansas File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// California Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/California/California Education GASB Data.xlsx", firstrow clear

drop if LEAID =="0"
drop if LEAID =="00"
drop if LEAID ==""

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0
drop if TOTALEXP <0

egen count = count(LEAID), by(LEAID)

keep if count ==8

drop I K L M N


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// California ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/California/2015-2022 GASB 68 & NCES California File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Colorado Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Utah/Utah Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Colorado ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)


/// District Contributions ///


preserve

gen weight =0

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// State Contributions ///


preserve

gen weight =0

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight =0

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Colorado/2015-2022 GASB 68 & NCES Colorado File.dta", replace






//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Connecticut Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Connecticut/Connecticut Education GASB Data.xlsx", firstrow

drop if Year ==.
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

destring district_contributions, replace

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Connecticut ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Connecticut/2015-2022 GASB 68 & NCES Connecticut File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Delaware Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Delaware/Delaware Education GASB.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Delaware ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Delaware/2015-2022 GASB 68 & NCES Delaware File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Florida Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Florida/Florida Education GASB.xlsx", sheet("Final Data") firstrow

drop if LEAID ==.

tostring LEAID, replace
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Florida ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Florida/2015-2022 GASB 68 & NCES Florida File.dta", replace


//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Georgia Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Georgia/Georgia Education GASB.xlsx", sheet("Final Data") firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Georgia ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Georgia/2015-2022 GASB 68 & NCES Georgia File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Hawaii Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////



clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Hawaii/Hawaii Education GASB Data.xlsx", firstrow

tostring LEAID, replace

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E17 E09 E08 E07 E11 V40 V45 V90 {
	gen `var'_pp = `var'/V33
}

drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =. 
gen sc_share_schools =.
gen tc_share_schools =.


/// Hawaii ///


replace dc_share_schools = district_contributions / (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)

replace sc_share_schools = state_contributions / (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)

replace tc_share_schools = total_contributions / (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)


/// TC Share Breakdown ///

preserve

gen weight = (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore

/// DC Share Breakdown ///

preserve

gen weight = (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore

/// SC Share Breakdown ///

preserve

gen weight = (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Hawaii/2015-2022 GASB 68 & NCES Hawaii File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Idaho Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Idaho/Idaho GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="."
drop if Year ==.
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Idaho ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Idaho/2015-2022 GASB 68 & NCES Idaho File.dta", replace


//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Illinois Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Illinois/Illinois Education GASB Data.xlsx", firstrow

tostring LEAID, replace

drop if LEAID=="0"
drop if LEAID=="."
drop if LEAID ==""
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E17 E09 E08 E07 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}

drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G

replace district_contributions_win = district_contributions if district_name =="Chicago Public Schools"
replace state_contributions_win = state_contributions if district_name =="Chicago Public Schools"
replace total_contributions_win = district_contributions if district_name =="Chicago Public Schools" 

replace TCURINST_win = TCURINST if district_name =="Chicago Public Schools"
replace E17_win = E17 if district_name =="Chicago Public Schools"
replace E07_win = E07 if district_name =="Chicago Public Schools"
replace E08_win = E08 if district_name =="Chicago Public Schools"
replace E09_win = E09 if district_name =="Chicago Public Schools"
replace V90_win = V90 if district_name =="Chicago Public Schools"
replace district_contributions_win = district_contributions if district_name =="Chicago Public Schools"
replace state_contributions_win = state_contributions if district_name =="Chicago Public Schools"
replace total_contributions_win = total_contributions if district_name =="Chicago Public Schools"


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =. 
gen sc_share_schools =.
gen tc_share_schools =.


/// Illinois ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

/// TC Share Breakdown ///

preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore

/// DC Share Breakdown ///

preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore

/// SC Share Breakdown ///

preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Illinois/2015-2022 GASB 68 & NCES Illinois File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Indiana Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Indiana/Indiana Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Indiana ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Indiana/2015-2022 GASB 68 & NCES Indiana File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Iowa Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Iowa/Iowa Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Iowa ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Iowa/2015-2022 GASB 68 & NCES Iowa File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Kansas Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Kansas/Kansas Education GASB Data.xlsx", firstrow clear

drop if LEAID ==""

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0
drop if TOTALEXP <0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Kansas ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Kansas/2015-2022 GASB 68 & NCES Kansas File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Kentucky Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Kentucky/Kentucky Education GASB Data.xlsx", sheet("Final ") firstrow clear

tostring LEAID, replace
drop if LEAID==""
drop if LEAID=="."
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

destring state_contributions, replace

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////

gen sc_share_schools =.

/// Kentucky ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore

save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Kentucky/2015-2022 GASB 68 & NCES Kentucky File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Louisiana Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear


import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Louisiana/Louisiana Education GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

replace LEAID = "2200247" if district_name == "DELTA CHARTER GROUP" & Year == 2015

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Louisiana ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

keep if tc_share_schools > 0 & tc_share_schools < 1

/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Louisiana/2015-2022 GASB 68 & NCES Louisiana File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Maine Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Maine/Maine Education GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Maine ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools =0 if dc_share_schools==.

/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Maine/2015-2022 GASB 68 & NCES Maine File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Maryland Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Maryland/Maryland Education GASB Data.xlsx", sheet("Sheet1") firstrow clear

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

destring district_contributions, replace


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Maryland ///


replace sc_share_schools = state_contributions / (TCURINST + E08 + E09 + E07)

replace dc_share_schools = district_contributions / (TCURINST + E08 + E09 + E07)

replace tc_share_schools = total_contributions / (TCURINST + E08 + E09 + E07)


/// State Contributions ///


preserve

gen weight = (TCURINST + E08 + E09 + E07)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST + E08 + E09 + E07)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST + E08 + E09 + E07)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Maryland/2015-2022 GASB 68 & NCES Maryland File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Massachusetts Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Massachusetts/Massachusetts Education GASB Data.xlsx", sheet("Sheet1") firstrow

tostring LEAID, replace
drop if LEAID=="0"
drop if LEAID=="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen sc_share_schools =.


/// Massachusetts ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Massachusetts/2015-2022 GASB 68 & NCES Massachusetts File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Michigan Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Michigan/Michigan Education GASB Data.xlsx", sheet("Sheet1") firstrow

tostring LEAID, gen(LEAID2)
drop LEAID
rename LEAID2 LEAID
drop if Year ==2023
drop if LEAID =="."

destring district_contributions, replace

merge 1:1 Year LEAID using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge ==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC TCURSSVC TCUROTH E17 E09 E08 E07 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G

//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Michigan ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + V40_win + E09_win + E07_win + E08_win + V90_win + V45_win + E17_win + E11_win)


preserve

gen weight = (TCURINST_win + V40_win + E09_win + E07_win + E08_win + V90_win + V45_win + E17_win + E11_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Michigan/2015-2022 GASB 68 & NCES Michigan File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Minnesota Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Minnesota/Minnesota Education GASB Data.xlsx", firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Minnesota ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Minnesota/2015-2022 GASB 68 & NCES Minnesota File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Mississippi Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Mississippi/Mississippi Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023
drop if Year ==2024

tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Iowa ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Mississippi/2015-2022 GASB 68 & NCES Mississippi File.dta", replace


//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Missouri Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Missouri/Missouri Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Missouri ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E08_win + E09_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win) if district_name =="St. Louis Public Schools"



/// District Contributions ///


preserve

gen weight = (TCURINST_win + E08_win + E09_win)

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win) if district_name =="St. Louis Public Schools"

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Missouri/2015-2022 GASB 68 & NCES Missouri File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Montana Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Montana/Montana Education GASB Data.xlsx", sheet("Sheet1") firstrow clear

destring district_contributions, replace
destring state_contributions, replace

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

append using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Montana/Additional Montana Education GASB Data.dta"


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(district_name), by(district_name)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop if plan ==""


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Georgia ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Montana/2015-2022 GASB 68 & NCES Montana File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Nebraska Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Nebraska/Nebraska Education GASB Data.xlsx", firstrow clear

drop if Year ==2023
tostring LEAID, replace

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Nebraska ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Nebraska/2015-2022 GASB 68 & NCES Nebraska File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Nevada Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Nevada/Nevada GASB Education Data.xlsx", sheet("Sheet1") firstrow

tostring LEAID, replace
drop if LEAID =="0"
drop if Year==2023

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"

keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0
drop if TOTALEXP <0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Nevada ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Nevada/2015-2022 GASB 68 & NCES Nevada File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// New Hampshire Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Hampshire/New Hampshire GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="."
drop if Year ==.
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// New Hampshire ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if dc_share_schools <0

egen count = count(LEAID), by(LEAID)

keep if count ==8


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Hampshire/2015-2022 GASB 68 & NCES New_Hampshire File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// New Jersey Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Jersey/New Jersey Education GASB Data.xlsx", sheet("Sheet1") firstrow

tostring LEAID, replace
drop if LEAID==""
drop if LEAID=="."
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
drop if V33 <=0
replace V33 = 733 if Year == 2019 & district_name =="METS CHARTER SCHOOL"

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G

drop if district_name =="UNIVERSITY HEIGHTS CHARTER SCHL"
drop if district_name =="University Heights Charter Schl"


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen sc_share_schools =.


/// New Jersey ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win)


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Jersey/2015-2022 GASB 68 & NCES New_Jersey File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// New Mexico Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Mexico/New Mexico GASB 68 Results.xlsx", sheet("Final Data") firstrow

tostring LEAID, replace
drop if LEAID==""
drop if LEAID=="."
drop if Year ==2023

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G

//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// New Mexico ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win + V90_win + V40_win + V45_win)

drop if dc_share<0


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win + V90_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_Mexico/2015-2022 GASB 68 & NCES New_Mexico File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// New York Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_York/Double Entries.xlsx", sheet("Sheet1") firstrow

collapse (sum) district_contributions, by(district_name Year LEAID)

save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_York/Double Entries.dta", replace

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_York/New York Education GASB Data.xlsx", sheet("Summary") firstrow

drop if district_name == "Adirondack" | ///
        district_name == "Clinton" | ///
        district_name == "Jamestown" | ///
        district_name == "Jefferson" | ///
        district_name == "Onondaga" | ///
        district_name == "Tuckahoe" | ///
        district_name == "Dutchess" | ///
        district_name == "Nassau" | ///
        district_name == "Oswego" | ///
        district_name == "Rockland"

append using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_York/Double Entries.dta", force

tostring LEAID, replace
drop if LEAID=="."
drop if LEAID=="0"
drop if Year ==2023

replace plan = "New York State Teachers' Retirement System" if plan ==""
replace State = "New York" if State ==""
replace state_abv = "NY" if state_abv ==""


merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
drop if V33 <=0

foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G


//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// New York ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E08_win + E09_win + E07_win)

drop if dc_share_schools <0

egen count = count(LEAID), by(LEAID)

keep if count ==8


preserve

gen weight = (TCURINST_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/New_York/2015-2022 GASB 68 & NCES New_York File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// North Carolina Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/North_Carolina/North Carolina Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// North Carolina ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/North_Carolina/2015-2022 GASB 68 & NCES North_Carolina File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Connecticut Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/North_Dakota/North Dakota GASB Education Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="0"
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// North Dakota ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/North_Dakota/2015-2022 GASB 68 & NCES North_Dakota File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Ohio Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Ohio/Ohio GASB Education Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="0"
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Ohio ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Ohio/2015-2022 GASB 68 & NCES Ohio File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Oklahoma Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Oklahoma/Oklahoma Education GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if Year ==.
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Oklahoma ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Oklahoma/2015-2022 GASB 68 & NCES Oklahoma File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Oregon Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Oregon/Oregon Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Oregon ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Oregon/2015-2022 GASB 68 & NCES Oregon File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Rhode Island Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Rhode_Island/Rhode Island Education GASB Data.xlsx", firstrow

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Maine ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Rhode_Island/2015-2022 GASB 68 & NCES Rhode_Island File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// South Dakota Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/South_Dakota/South Dakota Education GASB.xlsx", sheet("Sheet1") firstrow

rename LEIAD LEAID

drop if Year ==2023
tostring LEAID, replace
drop if LEAID ==""

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// South Dakota ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if tc_share_schools < 0

egen count = count(LEAID), by(LEAID)

keep if count ==8


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/South_Dakota/2015-2022 GASB 68 & NCES South_Dakota File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Tennessee Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Tennessee/Tennessee Education GASB.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Tennessee ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E08_win + E09_win + E07_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Tennessee/2015-2022 GASB 68 & NCES Tennessee File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Texas Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Texas/Texas Education GASB Data.xlsx", firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Texas ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Texas/2015-2022 GASB 68 & NCES Texas File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Utah Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Utah/Utah Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Utah ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)



/// District Contributions ///


preserve

gen weight =0

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Utah/2015-2022 GASB 68 & NCES Utah File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Vermont Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Vermont/Vermont Education GASB Data.xlsx", sheet("Sheet1") firstrow

tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:m LEAID Year using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Vermont/NCES Fiscal 2015-2022 (Vermont).dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen sc_share_schools =.


/// Vermont ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Vermont/2015-2022 GASB 68 & NCES Vermont File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Virginia Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Virginia/Virginia Education GASB Data.xlsx", firstrow clear

tostring LEAID, replace
drop if LEAID==""
drop if LEAID=="."
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 V95 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// Virginia ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Virginia/2015-2022 GASB 68 & NCES Virginia File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Washington Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Washington/Washington Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023
tostring LEAID, replace
drop if LEAID =="."
drop if LEAID =="0"

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0

egen count = count(LEAID), by(LEAID)

keep if count ==8

foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G




//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Washington ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E09_win + E07_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Washington/2015-2022 GASB 68 & NCES Washington File.dta", replace





//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Washington DC Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Washington_DC/Washington DC Education GASB.xlsx", sheet("Sheet1") firstrow

tostring LEAID, replace

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	gen `var'_pp = `var'/V33
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Washington DC ///


replace dc_share_schools = district_contributions / (TCURINST + E17 + E07 + E09)


/// District Contributions ///


preserve

gen weight = (TCURINST + E17 + E07 + E09)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Washington_DC/2015-2022 GASB 68 & NCES Washington_DC File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// West Virginia Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/West_Virginia/West Virginia Education GASB Data.xlsx", firstrow clear

tostring LEAID, replace
drop if LEAID==""
drop if LEAID=="."
drop if LEAID=="0"
drop if Year ==2023
merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge

replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions state_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.
gen sc_share_schools =.
gen tc_share_schools =.


/// West Virginia ///


replace sc_share_schools = state_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

replace tc_share_schools = total_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win)


/// State Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(sc_share_schools)

collapse (mean) sc_share_schools [aw=weight], by(Year)

restore


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


/// Total Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win)

drop if weight <0

tab Year, summarize(tc_share_schools)

collapse (mean) tc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/West_Virginia/2015-2022 GASB 68 & NCES West_Virginia File.dta", replace




//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Wisconsin Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Wisconsin/Wisconsin Education GASB Data.xlsx", sheet("Sheet1") firstrow

drop if Year ==2023

tostring LEAID, replace
drop if LEAID =="."

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Wisconsin ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Wisconsin/2015-2022 GASB 68 & NCES Wisconsin File.dta", replace



//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

///// Wyoming Dataset //////

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

clear

import excel "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Wyoming/Wyoming Education GASB.xlsx", firstrow

drop if Year ==2023

tostring LEAID, replace

merge 1:1 LEAID Year using "/Users/gregkearney/Documents/Spending Project/'NCES Data/NCES Fiscal Data/NCES Fiscal 2015-2022.dta"
keep if _merge==3
drop _merge


replace V33 = MEMBERSCH if V33 <= 0
replace MEMBERSCH = V33 if MEMBERSCH <=0
count if V33 <=0
drop if V33 <=0


egen count = count(LEAID), by(LEAID)

keep if count ==8


foreach var of varlist district_contributions total_contributions TCURINST TCURELSC E07 E17 E09 E08 E11 V40 V45 V90 {
	winsor `var', gen(`var'_win) p(0.01)
	gen `var'_pp = `var'/V33
	winsor `var'_pp, gen(`var'_pp_win) p(0.01)
}


drop FL_V33 FL_MEMBERSCH FL_C14 FL_C15 FL_C16 FL_C17 FL_C19 FL_B11 FL_C20 FL_C25 FL_C36 FL_B10 FL_B12 FL_B13 FL_C01 FL_C04 FL_C05 FL_C06 FL_C07 FL_C08 FL_C09 FL_C10 FL_C11 FL_C12 FL_C13 FL_C35 FL_C38 FL_C39 FL_T02 FL_T06 FL_T09 FL_T15 FL_T40 FL_T99 FL_D11 FL_D23 FL_A07 FL_A08 FL_A09 FL_A11 FL_A13 FL_A15 FL_A20 FL_A40 FL_U11 FL_U22 FL_U30 FL_U50 FL_U97 FL_C24 FL_E13 FL_V91 FL_V92 FL_E11 FL_E17 FL_E07 FL_E08 FL_E09 FL_V40 FL_V45 FL_V90 FL_V85 FL_V60 FL_V65 FL_V70 FL_V75 FL_V80 FL_F12 FL_G15 FL_K09 FL_K10 FL_K11 FL_L12 FL_M12 FL_Q11 FL_I86 FL_Z32 FL_Z33 FL_Z35 FL_Z36 FL_Z37 FL_Z38 FL_V11 FL_V13 FL_V15 FL_V17 FL_V21 FL_V23 FL_V37 FL_V29 FL_Z34 FL_V10 FL_V12 FL_V14 FL_V16 FL_V18 FL_V22 FL_V24 FL_V38 FL_V30 FL_V32 FL_V93 FL_19H FL_21F FL_31F FL_41F FL_61V FL_66V FL_W01 FL_W31 FL_W61 FL_V95 FL_V02 FL_K14 FL_CE1 FL_CE2 FL_CE3 FL_C22 FL_C23 FL_C26 FL_C27 FL_B14 FL_SE1 FL_SE2 FL_SE3 FL_SE4 FL_SE5 FL_AR1 FL_AR2 FL_AR3 FL_AR4 FL_AR5 FL_AR6 FL_AE1 FL_AE2 FL_AE3 FL_AE4 FL_AE5 FL_AE6 FL_AR1A FL_AR1B FL_AR2A FL_AR6A FL_AE7 FL_AE8

drop FL_AE1A FL_AE1B FL_AE1C FL_AE1D FL_AE1E FL_AE1F FL_AE1G FL_AE2A FL_AE2B FL_AE2C FL_AE2D FL_AE2E FL_AE2F FL_AE2G FL_AE4A FL_AE4B FL_AE4C FL_AE4D FL_AE4E FL_AE4F FL_AE4G



//////
//// Making Contribution Totals Based on Pension System Criteria ////
//////


gen dc_share_schools =.


/// Wyoming ///


replace dc_share_schools = district_contributions_win / (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)


/// District Contributions ///


preserve

gen weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win)

drop if weight <0

tab Year, summarize(dc_share_schools)

collapse (mean) dc_share_schools [aw=weight], by(Year)

restore


save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/Wyoming/2015-2022 GASB 68 & NCES Wyoming File.dta", replace




/////////////
///////////// Combining All States //////////////
/////////////

clear

set more off

local base_path "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States"

* Define state names correctly (no quotes around the list)

local states Alabama Alaska Arizona Arkansas California Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada Ohio Oklahoma Oregon Tennessee Texas Utah Vermont Virginia Washington Wisconsin Wyoming New_Hampshire North_Carolina New_Jersey New_Mexico New_York North_Dakota Rhode_Island South_Dakota Washington_DC West_Virginia

* Initialize first dataset

local first = 1

foreach state in `states' {
    * Construct file path (ensure quotes handle spaces correctly)
	
    local file_path "`base_path'/`state'/2015-2022 GASB 68 & NCES `state' File.dta"

    * Check if the file exists before attempting to use or append
	
    capture confirm file "`file_path'"
    if _rc == 0 {  
        if `first' == 1 {
            use "`file_path'", clear
            local first = 0
        }
        else {
            append using "`file_path'", force
        }
    }
    else {
        di as error "File not found: `file_path'"
    }
}

drop employer_code O P Q J K _merge employer_id L M employer_number code N ID County count

replace tc_share_schools = dc_share_schools if tc_share_schools ==.
replace tc_share_schools = sc_share_schools if tc_share_schools ==.

merge m:1 State using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/'Bargaining Status.dta"

drop _merge

merge m:m State Year using "/Users/gregkearney/Documents/Yearly Funding Ratios.dta"

drop _merge


////// Ensuring District Names are the Same Across Years //////

gen district_name_2015 = ""

gen temp_district_name = district_name if Year == 2015

bysort LEAID (Year): replace temp_district_name = temp_district_name[_n-1] if missing(temp_district_name)

replace district_name_2015 = temp_district_name

drop temp_district_name

drop district_name

order LEAID Year State state_abv plan district_name_2015

rename district_name_2015 district_name

bysort LEAID: gen count = _N

sum count, detail


///// Summary Stats /////


preserve

collapse (mean) dc_share_schools sc_share_schools tc_share_schools, by(State Year bargaining_type party_affiliation union_rank)

tab Year, summarize(dc_share_schools)

tab Year, summarize(sc_share_schools)

tab Year, summarize(tc_share_schools)


tab Year party_affiliation, summarize(tc_share_schools)

tab Year party_affiliation, summarize(dc_share_schools)

tab Year party_affiliation, summarize(sc_share_schools)


//// 2015-2022 Change Breakdown ////

* Step 1: Sort data to ensure correct processing

sort State Year

* Step 2: Generate new variables for 2015 values

gen tc_2015 = .
gen sc_2015 = .
gen dc_2015 = .

* Step 3: Fill 2015 values for each state

bysort State (Year): replace tc_2015 = tc_share_schools if Year == 2015
bysort State (Year): replace sc_2015 = sc_share_schools if Year == 2015
bysort State (Year): replace dc_2015 = dc_share_schools if Year == 2015

* Step 4: Generate new variables for 2022 values

gen tc_2022 = .
gen sc_2022 = .
gen dc_2022 = .

* Step 5: Fill 2022 values for each state

bysort State (Year): replace tc_2022 = tc_share_schools if Year == 2022
bysort State (Year): replace sc_2022 = sc_share_schools if Year == 2022
bysort State (Year): replace dc_2022 = dc_share_schools if Year == 2022

* Step 6: Propagate 2015 and 2022 values for each state

bysort State (Year): replace tc_2015 = tc_2015[_n-1] if missing(tc_2015)
bysort State (Year): replace sc_2015 = sc_2015[_n-1] if missing(sc_2015)
bysort State (Year): replace dc_2015 = dc_2015[_n-1] if missing(dc_2015)

bysort State (Year): replace tc_2022 = tc_2022[_n+1] if missing(tc_2022)
bysort State (Year): replace sc_2022 = sc_2022[_n+1] if missing(sc_2022)
bysort State (Year): replace dc_2022 = dc_2022[_n+1] if missing(dc_2022)

* Step 7: Calculate the change from 2015 to 2022

gen tc_change = tc_2022 - tc_2015
gen sc_change = sc_2022 - sc_2015
gen dc_change = dc_2022 - dc_2015

* Step 8: Keep only unique state-year observations for clarity

bysort State (Year): keep if Year == 2022

tab Year party_affiliation, summarize(tc_change)
tab Year party_affiliation, summarize(dc_change)
tab Year party_affiliation, summarize(sc_change)

drop if State =="Alaska"

tab Year party_affiliation, summarize(tc_change)
tab Year party_affiliation, summarize(dc_change)
tab Year party_affiliation, summarize(sc_change)


restore



* Save final dataset

save "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/'Full State Dataset.dta", replace



