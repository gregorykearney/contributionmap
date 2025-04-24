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


//////// Adding in Teacher Counts ////////


merge 1:1 Year LEAID using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/'Teacher Counts/2015-2022 Full Count.dta"

drop if _merge ==2

drop _merge

sort LEAID Year

replace teacher_count = 0 if teacher_count ==.

replace teacher_count = 0 if teacher_count ==-9


/// If 2015 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2015 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2016 & teacher_count[_n+1] > 0
	
replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0

drop teacher_count_fixed


/// If 2016 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2016 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2017 & teacher_count[_n+1] > 0
	
replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0	

drop teacher_count_fixed


/// If 2017 is Missing but Available for All Other Years ///
	

gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2017 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2018 & teacher_count[_n+1] > 0

replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0
	
drop teacher_count_fixed
	

/// If 2018 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2018 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2019 & teacher_count[_n+1] > 0

replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0

drop teacher_count_fixed
	

/// If 2019 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2019 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2020 & teacher_count[_n+1] > 0

replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0
	
drop teacher_count_fixed	


/// If 2020 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2020 & teacher_count == 0 & ///
    LEAID == LEAID[_n+1] & Year[_n+1] == 2021 & teacher_count[_n+1] > 0

replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0

drop teacher_count_fixed


/// If 2021 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n-1] if ///
    Year == 2022 & teacher_count == 0 & ///
    LEAID == LEAID[_n-1] & Year[_n-1] == 2021 & teacher_count[_n-1] > 0
	
replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0
	
drop teacher_count_fixed


/// If 2022 is Missing but Available for All Other Years ///


gen teacher_count_fixed = teacher_count

replace teacher_count_fixed = teacher_count[_n+1] if ///
    Year == 2022 & missing(teacher_count) & ///
    LEAID == LEAID[_n-1] & Year[_n-1] == 2021 & teacher_count[_n-1] > 0

replace teacher_count = teacher_count_fixed if teacher_count_fixed > 0 & teacher_count ==0

drop teacher_count_fixed


/// Teacher Salaries per FTE ///


gen salary_pFTE = Z33 / teacher_count

winsor salary_pFTE, gen(salary_pFTE_win) p(0.01)

tab Year, summarize(salary_pFTE_win)


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


/// Creating Weights ///

gen weight =.

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State == "Alabama"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Alaska"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State =="Arizona"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win) if State =="Arkansas"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="California"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win) if State =="Connecticut"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win) if State =="Delaware"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win) if State =="Florida"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win) if State =="Georgia"

replace weight = (TCURINST + E17 + E08 + E09 + E07 + V90 + E11 + V45 + V40) if State =="Hawaii"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State=="Idaho"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + V90_win + E07_win + V40_win) if State =="Illinois"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Indiana"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State =="Iowa"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State =="Kansas"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win) if State =="Kentucky"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win) if State =="Louisiana"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Maine"

replace weight = (TCURINST + E08 + E09 + E07) if State=="Maryland"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Massachusetts"

replace weight = (TCURINST_win + V40_win + E09_win + E07_win + E08_win + V90_win + V45_win + E17_win + E11_win) if State =="Michigan"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Minnesota"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win) if State=="Mississippi"

replace weight = (TCURINST_win + E08_win + E09_win) if State =="Missouri"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State=="Montana"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win) if State =="Nebraska"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State=="Nevada"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State=="New Hampshire"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win) if State =="New Jersey"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + E11_win + V90_win + V40_win + V45_win) if State=="New Mexico"

replace weight = (TCURINST_win + E08_win + E09_win + E07_win) if State =="New York"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State=="North Carolina"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="North Dakota"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Ohio"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State=="Oklahoma"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win) if State =="Oregon"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="Rhode Island"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V45_win) if State =="South Dakota"

replace weight = (TCURINST_win + E08_win + E09_win + E07_win) if State =="Tennessee"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V90_win) if State =="Texas"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + V45_win + V40_win + E11_win) if State =="Utah"

replace weight = (TCURINST_win + E17_win + E09_win + E07_win) if State =="Vermont"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V40_win + V95_win) if State =="Virginia"

replace weight = (TCURINST_win + E17_win + E09_win + E07_win) if State =="Washington"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win) if State =="West Virginia"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State=="Wisconsin"

replace weight = (TCURINST_win + E17_win + E08_win + E09_win + E07_win + V90_win + E11_win + V45_win + V40_win) if State =="Wyoming"

replace weight = (TCURINST + E17 + E07 + E09) if State =="Washington DC"

drop if weight <0


/// Unweighted ///


preserve

collapse (mean) dc_share_schools sc_share_schools tc_share_schools, by(State Year bargaining_type party_affiliation union_rank)

tab Year, summarize(dc_share_schools)

tab Year, summarize(sc_share_schools)

tab Year, summarize(tc_share_schools)


tab Year party_affiliation, summarize(tc_share_schools)

tab Year party_affiliation, summarize(dc_share_schools)

tab Year party_affiliation, summarize(sc_share_schools)

restore


/// Weighted ///


preserve

collapse (mean) dc_share_schools sc_share_schools tc_share_schools [aw=weight], by(State Year bargaining_type party_affiliation union_rank)

tab Year, summarize(dc_share_schools)

tab Year, summarize(sc_share_schools)

tab Year, summarize(tc_share_schools)

restore


//// 2015-2022 Change Breakdown ////

* Step 1: Sort data to ensure correct processing

preserve

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

