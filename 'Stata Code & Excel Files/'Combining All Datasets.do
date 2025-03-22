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

drop employer_code O P Q J K _merge employer_id L M employer_number code N ID County

replace tc_share_schools = dc_share_schools if tc_share_schools ==.
replace tc_share_schools = sc_share_schools if tc_share_schools ==.

merge m:1 State using "/Users/gregkearney/Documents/Spending Project/'Quant Analysis/Additional States/'Bargaining Status.dta"

drop _merge

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

