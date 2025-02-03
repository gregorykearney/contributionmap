The idea behind this project is that we're trying to observe how much pension contributions are comprising of certain expenditure categories related to state and local spending on education. 
The "expenditure categories" that we're interested in observing vary state to state and are determined by which employee classifications are covered by the teachers' unions of different states. We are able to do this using two different datasets:

i) GASB 68 reports for each state which report the district and state pension expenditures; and

ii) The district-level NCES state and local fiscal survey which reports education expenditures across various line items (e.g., teachers, school psychologists, librarians, cafeteria workers etc.)
(you can find the updated data here: https://nces.ed.gov/ccd/files.asp#Fiscal:1,LevelId:5,Page:1)

The GASB 68 reports are reported each year and are provided well in advance of the NCES dataset updates, so you should have no problem having up to date GASB 68 data. However, the NCES data is lagged a bit and allegedly is provided July of each year. 
I say allegedly because prepare to wait until October more realisitically. So, at present the 2023 GASB 68 reports are out for each state, but the NCES data is only through 2022. 

Some states unfortunately do not have teachers' unions and instead have public employee retirement pension funds, which adds a layer of complication to the analysis. Thus, as you may expect, the GASB 68 data include tons of different data that are totally
irrelevant to the project in these reports. However, thankfully they do provide school districts within the data. I'll say more on this later.

As for the datasets, here are some of the things to keep in mind as you collect them / assign amounts correctly:

GASB 68 Data

For many states, they will provide district level pension contribution amounts with the title of "employer name." It's important to note that these amounts often DO NOT include state contributions. States will do one of two things in this circumstance - 
i) they will provide a separate column that includes the state contributions by district (i.e., the ideal approach) or ii) they will provide the state contribution amount in the aggregate at the end of the table. We have tried to look into getting those
state contributions by district, and unfortunately states make this difficult. 

To deal with this, we decided to distribute state funds based on the proportion of total district-level contributions each district contributed. So for example, if Union County school district in NJ contributed 0.02% of the total district contribution figure, 
we distributed 0.02% of state contributions to this district. This is imperfect as you may notice when going through GASB documentation. For example, in Illinois, district contributions are based on payroll, but state contributions are based partly on payroll
as well as the extent to which the district is individually underfunded. Thus, in some cases were are understimating/overestimating the amount a district is receiving from the state. 

We have matched as many districts as we could from the GASB 68 data to the NCES data, so those match IDs have been done. But, just as a note, you'll probably find that our total is well below the amount of districts we're analyzing in our analysis. For example,
California's GASB 68 has reported almost 1200 districts starting in 2020. Many of these districts are either incredibly small or don't report any data. California based on its own website has around 977 districts (we have analyzed 967), so to deal with the extra districts
that may or may not have sufficient data, we only focused on the districts that had all 8 years of data between 2015-2022. 

Below when I detail each state's variables, I will provide a link to each website's GASB 68 files to make it faster to track down the webpages (this proved to be a pain at times).

NCES Data

The NCES data is fairly straightforward. We used the "LEAID" variable to match this dataset to the collected GASB data. This work has been done for you, so all you'll have to do is ensure that you're properly assigning the proper LEAID figure to the newly collected GASB district.

From my earlier explanation about state funds, you may be wondering how might NCES be divvying out state contributions to the districts if the state doesn't report the distribution of state funds to the districts? This is a great question - in the documentation which you can find at
the link I provided above, NCES states that it imputes state amounts based on its own assumptions for each district. Thus, with relative confidence, we believe we're fine with our numbers when averaged across districts.

The variables of interest you'll see in the code are as follows:

TCURINST - Total instruction spending
E17 - Total expenditures for support services for pupils
E07 - Total expenditures for support services for instructional staff
E08 - Total expenditures for support services for general administration
E09 - Total expenditures for support services for school administration
V40 - Total expenditures for support services for operation and maintenances of plant
V45 - Total expenditures for support services for student transportation
V90 - Total expenditures for support services for business / central / other
E11 - Total expenditures for food services

As mentioned earlier, the choice of variables is determined by the membership criteria of each retirement system. For example, some states will include cafeteria workers (E11) in its public employees retirement system and others will include them in the teachers' retirement system.

State-by-State Details

i) Alabama

Membership criteria: https://www.rsa-al.gov/trs/#:~:text=Since%201939%2C%20The%20Teachers'%20Retirement,institutions%2C%20and%20state%20education%20agencies
GASB 68 Reports: https://www.rsa-al.gov/employers/financial-reports/gasb-68-reports-archive/#TRS%202023

Alabama has an expansive definition for membership within the TRS. Thus, we included all of the variables above. For completeness, they are as follows:

TCURINST, E17, E07, E08, E09, V40, V45, V90, E11

Absent a serious policy change in the last couple of years, contributions should remain fairly flat. As a percentage of these expenditure categories, contributions have hovered around 6.3% between 2015-2022. 

ii) Alaska











