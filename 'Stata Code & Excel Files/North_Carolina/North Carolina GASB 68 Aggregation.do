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
