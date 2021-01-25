cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV"

/*import the data from int_access_empow file and transform it in dta*/

insheet using "int_cohesion_empow.csv",clear
sort hhid 
save "int_cohesion_empow.dta", replace

/*import the data from int_access_health file, transform it in dta and then
merge it with int_access_empow database*/
insheet using "int_access_health.csv",clear
sort hhid
merge m:1 hhid using "int_cohesion_empow.dta"
drop _merge

duplicates report

/*save the merged database*/
save "applied.dta",replace

/*used the database SAGE_HHWEIGHTSV2.csv, create dummy variables from 
targetingmethod and eligibilitystatus variables and merge it with the
upper new database */
insheet using "SAGE_HHWEIGHTSV2.csv",clear
summ
sort hhid

tab targetingmethod, gen(var)
rename var1 OAG
rename var2 VGFG

tab eligilitystatus, gen(var)
rename var1 Eligible
rename var2 Ineligible

/* we drop these two variables for technical purposes */
drop targetingmethod eligilitystatus

save "SAGE_HHWEIGHTSV2.dta",replace

use "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV\applied.dta",clear

merge m:1 hhid using "SAGE_HHWEIGHTSV2.dta"
drop _merge

summarize

/*
gen keyvar = 1 if var1==1
gen keyvar = 2 if var2==0
*/


local varlist "hh1_q2 hh1_q7 hh1_q9 hh1_q12 hh1_q19 hh2_q3 hh2_q4 hh2_q5 hh2_q7 hh2_q8 hh2_q9 hh2_q10 hh2_q11 hh3_q1 hh4_q2 hh4_q3 hh4_q4 hh4_q5 hh4_q6 hh4_q7 hh4_q9 hh4_q10 hh4_q11"
foreach i of varlist `varlist'{
	summ `i' if `i'==98
	summ `i' if `i'==.
	replace `i' =. if  `i'== 98 
}

local varlist2 "hh4_q16 hh4_q17 hh4_q18 hh4_q19 hh4_q20"
foreach i of varlist `varlist2'{
	summ `i' if `i'==998
	summ `i' if `i'==.
	replace `i' =. if `i' == 998
}

summarize

/*we eliminate the part of the subsample concerned by the Old Agent Grant*/
drop if OAG==1
drop hh1_q5 hh1_q8 hh1_q10 hh1_q13 hh1_q15 hh1_q16 hh1_q17 hh1_q20 hh1_q21 hh2_q1 hh2_q2 hh2_q6 hh2_q6oth hh2_q8oth hh2_q9oth hh2_q11oth  hh3_q2 hh3_q3 hh3_q4 hh3_q4oth hh3_q5 hh3_q5oth hh3_q6a hh3_q6b hh3_q7 hh3_q8 hh4_q3 hh4_q4 hh4_q5 hh4_q8a1 hh4_q8a2 hh4_q8d1 hh4_q8d2 hh4_q8e1 hh4_q8e2 hh4_q8f1 hh4_q8f2 hh4_q8g1 hh4_q8g2 hh4_q10 hh4_q12 hh4_q13 hh4_q14a hh4_q14b hh4_q14aoth hh4_q15 doi moi yoi hh1_q4oth hh1_q21oth hh4_q14both hh4_q14bother hh1_q21other hh2_q6other hh2_q9other hh3_q4other hh3_q5other hh1_q4other reason_noconsultation_1 reason_noconsultation_2 reason_noconsultation_3 reason_noconsultation_4 reason_noconsultation_6 reason_noconsultation_7 reason_noconsultation_8 reason_noconsultation_9 reason_noconsultation_10 reason_noconsultation_11 reason_noconsultation_12 reason_noconsultation_13 reason_noconsultation_97 reason_noconsultation_98

summ

/*renaming some variables*/
rename hh1_q2 age
rename hh1_q4 Datebirthrecorded
rename hh1_q6 Famrelation
rename hh1_q7 MaritialStatus
rename hh1_q9 FatherAlive
rename hh1_q11 Educationfather
rename hh1_q12 MotherAlive
rename hh1_q14 EducationMother
rename hh1_q18 NumberofMeals
rename hh1_q19 Disability
rename hh2_q3 School 
rename hh2_q4 PresentGrade
rename hh2_q5 PastGrade
rename hh2_q7 DaysMissSchool
rename hh2_q8 ReasonMissSchool
rename hh2_q9 ReasonNotSchool
rename hh2_q10 HighestGrade
rename hh2_q11 ReasonLeave
rename hh3_q1 Ilness30days
rename hh4_q2 Workedforpayment
/*rename hh4_q3 
rename hh4_q4
rename hh4_q5*/
rename hh4_q6 LookedForaJob 
rename hh4_q7 ReasonNotLookingforaJob 
rename hh4_q9 WorkingStatus
/*rename hh4_q10*/
rename hh4_q11 Monthsinactivity
rename hh4_q16 HoursSupplyWater
rename hh4_q17 HoursSupplyFirewood 
rename hh4_q18 HoursCooking 
rename hh4_q19 HoursChildcare
rename hh4_q20 HoursOtherChores

/*Changing Binary variables {1,2} to binary {1,2}*/
local varlist3 "FatherAlive MotherAlive Disability Workedforpayment LookedForaJob Ilness30days "
foreach i of varlist `varlist3'{
	summ `i' if `i'==2
	summ `i' if `i'==1
	replace `i' =0 if `i' == 2
}
 
summ Eligible female age FatherAlive Disability HoursSupplyWater HoursCooking HoursChildcare

/*Dependent Variable*/
summ hh7_q6i1 hh7_q6i2 hh7_q6i3

tab hh7_q6i1

//Cleaning raw data 
local varlist4 "hh7_q6i1 hh7_q6i2 hh7_q6i3"
foreach i of varlist `varlist4'{
    summ `i' if `i'==96
	summ `i' if `i'==99
	replace `i'=. if `i'==96
	replace `i'=. if `i'==99
}

rename hh7_q6i1 decisioneducation
rename hh7_q6i2 decisionhealth
rename hh7_q6i3 decisioninvestment

//Creating a household id
generate long order=_n
by hhid (order), sort: generate y = _n == 1
replace y = sum(y)
drop order

//Indentify which member of the household takes the decison
gen femaleeduc=.
gen femalehealth=.
gen femaleinvest=.

//Finally Creating dependent variables
replace  femaleeduc=1 if (decisioneducation==memid & female==1)
egen count_femaleeduc=total(femaleeduc),by(hhid)
replace  count_femaleeduc=. if decisioneducation==.  

replace  femalehealth=1 if (decisionhealth==memid & female==1)
egen count_femalehealth=total(femalehealth),by(hhid)
replace  count_femalehealth=. if decisioneducation==. 

replace  femaleinvest=1 if (decisioninvestment==memid & female==1)
egen count_femaleinvest=total(femaleinvest),by(hhid)
replace  count_femaleinvest=. if decisioninvestment==. 

rename count_femaleeduc feduc
rename count_femalehealth fhealth
rename count_femaleinvest finvest

save "FirstDatabase.dta",replace

//######################## ENDLINE #########################################

cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2014\UGA_2014_SAGE-EL_v01_M_CSV"

insheet using "int_cohesion_empow.csv",clear
sort hhid 
save "int_cohesion_empow2014.dta", replace

/*import the data from int_access_health file, transform it in dta and then
merge it with int_access_empow database*/
insheet using "int_access_health.csv",clear
sort hhid
merge m:1 hhid using "int_cohesion_empow2014.dta"
drop _merge

duplicates report

/*save the merged database*/
save "applied2014.dta",replace

/*used the database SAGE_HHWEIGHTSV2.csv, create dummy variables from 
targetingmethod and eligibilitystatus variables and merge it with the
upper new database */
insheet using "SAGE_HHWEIGHTSV2.csv",clear
summ
sort hhid

tab targetingmethod, gen(var)
rename var1 OAG2014
rename var2 VGFG2014

/* we drop these two variables for technical purposes */
drop targetingmethod 

save "SAGE_HHWEIGHTSV2_2014.dta",replace


use "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2014\UGA_2014_SAGE-EL_v01_M_CSV\applied2014.dta",clear

merge m:1 hhid using "SAGE_HHWEIGHTSV2_2014.dta"
drop _merge

local varlist "hh1_q2 hh1_q7 hh1_q9 hh1_q12 hh1_q19 hh2_q3 hh2_q4 hh2_q5 hh2_q7 hh2_q8 hh2_q9 hh2_q10 hh2_q11 hh3_q1 hh4_q2 hh4_q3 hh4_q4 hh4_q5 hh4_q6 hh4_q7 hh4_q9 hh4_q10 hh4_q11"
foreach i of varlist `varlist'{
	summ `i' if `i'==98
	summ `i' if `i'==.
	replace `i' =. if  `i'== 98 
}

local varlist2 "hh4_q16 hh4_q17 hh4_q18 hh4_q19 hh4_q20"
foreach i of varlist `varlist2'{
	summ `i' if `i'==998
	summ `i' if `i'==.
	replace `i' =. if `i' == 998
}

summarize

/*we eliminate the part of the subsample concerned by the Old Agent Grant*/
drop if OAG2014==1
drop hh1_q5 hh1_q8 hh1_q10 hh1_q13 hh1_q15 hh1_q16 hh1_q17 hh2_q1 hh2_q2 hh2_q6 hh2_q8_o hh2_q9_o hh2_q11_o  hh3_q2 hh3_q3 hh3_q4 hh3_q4_o hh3_q5 hh3_q5_o hh3_q6a hh3_q6b hh3_q7 hh3_q8 hh4_q3 hh4_q4 hh4_q5  hh4_q8a2  hh4_q8d2  hh4_q8e2  hh4_q8f2  hh4_q8g2 hh4_q10 hh4_q12 hh4_q13 hh4_q14a hh4_q14b hh4_q14a_o hh4_q15 hh1_q4_o hh2_q9_o hh3_q4_o hh3_q5_o hh1_q4_o reason_noconsultation_1 reason_noconsultation_2 reason_noconsultation_3 reason_noconsultation_4 reason_noconsultation_6 reason_noconsultation_9 reason_noconsultation_10 reason_noconsultation_11  reason_noconsultation_13 reason_noconsultation_97

browse
summ

/*renaming some variables*/
rename hh1_q2 age
rename hh1_q4 Datebirthrecorded
rename hh1_q6 Famrelation
rename hh1_q7 MaritialStatus
rename hh1_q9 FatherAlive
rename hh1_q11 Educationfather
rename hh1_q12 MotherAlive
rename hh1_q14 EducationMother
rename hh1_q18 NumberofMeals
rename hh1_q19 Disability
rename hh2_q3 School 
rename hh2_q4 PresentGrade
rename hh2_q5 PastGrade
rename hh2_q7 DaysMissSchool
rename hh2_q8 ReasonMissSchool
rename hh2_q9 ReasonNotSchool
rename hh2_q10 HighestGrade
rename hh2_q11 ReasonLeave
rename hh3_q1 Ilness30days
rename hh4_q2 Workedforpayment
/*rename hh4_q3 
rename hh4_q4
rename hh4_q5*/
rename hh4_q6 LookedForaJob 
rename hh4_q7 ReasonNotLookingforaJob 
rename hh4_q9 WorkingStatus
/*rename hh4_q10*/
rename hh4_q11 Monthsinactivity
rename hh4_q16 HoursSupplyWater
rename hh4_q17 HoursSupplyFirewood 
rename hh4_q18 HoursCooking 
rename hh4_q19 HoursChildcare
rename hh4_q20 HoursOtherChores

/*Changing Binary variables {1,2} to binary {1,2}*/
local varlist3 "FatherAlive MotherAlive Disability Workedforpayment LookedForaJob Ilness30days "
foreach i of varlist `varlist3'{
	summ `i' if `i'==2
	summ `i' if `i'==1
	replace `i' =0 if `i' == 2
}
 
summ Eligible female age FatherAlive Disability HoursSupplyWater HoursCooking HoursChildcare

/*Dependent Variable*/
summ hh7_q6i1 hh7_q6i2 hh7_q6i3

tab hh7_q6i1

//Cleaning raw data 
local varlist4 "hh7_q6i1 hh7_q6i2 hh7_q6i3"
foreach i of varlist `varlist4'{
    summ `i' if `i'==96
	summ `i' if `i'==99
	replace `i'=. if `i'==96
	replace `i'=. if `i'==99
}

rename hh7_q6i1 decisioneducation2014
rename hh7_q6i2 decisionhealth2014
rename hh7_q6i3 decisioninvestment2014

//Creating a household id
generate long order=_n
by hhid (order), sort: generate y = _n == 1
replace y = sum(y)
drop order

//Indentify which member of the household takes the decison
gen femaleeduc2014=.
gen femalehealth2014=.
gen femaleinvest2014=.

//Finally Creating dependent variables
replace  femaleeduc2014=1 if (decisioneducation2014==memid & female==1)
egen count_femaleeduc2014=total(femaleeduc2014),by(hhid)
replace  count_femaleeduc2014=. if decisioneducation2014==.  

replace  femalehealth2014=1 if (decisionhealth2014==memid & female==1)
egen count_femalehealth2014=total(femalehealth2014),by(hhid)
replace  count_femalehealth2014=. if decisioneducation2014==. 

replace  femaleinvest2014=1 if (decisioninvestment2014==memid & female==1)
egen count_femaleinvest2014=total(femaleinvest2014),by(hhid)
replace  count_femaleinvest2014=. if decisioninvestment2014==. 

rename count_femaleeduc2014 feduc2014
rename count_femalehealth2014 fhealth2014
rename count_femaleinvest2014 finvest2014

save "SecondDatabase.dta",replace


//I STAYED HEEEERRRRREEEEE 

cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV"

use "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV\FirstDatabase.dta",clear

merge m:1 hhid using "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2014\UGA_2014_SAGE-EL_v01_M_CSV\SecondDatabase.dta"











/*Summary of all our variables*/
summ hhid memid age Datebirthrecorded Famrelation MaritialStatus FatherAlive Educationfather MotherAlive EducationMother NumberofMeals Disability School PresentGrade PastGrade DaysMissSchool ReasonMissSchool ReasonNotSchool HighestGrade ReasonLeave Ilness30days Workedforpayment LookedForaJob ReasonNotLookingforaJob WorkingStatus Monthsinactivity HoursSupplyWater HoursSupplyFirewood  HoursCooking  HoursChildcare HoursOtherChores VGFG Eligible



/*Test whether age is different in one group and another*/
ttest age, by(Eligible)  

regress Eligible age
regress Eligible age  female Disability

browse

mean age if female==1
mean age if female==0
ttest age, by(female)  

histogram age if female==1
histogram age if female==0

histogram age if Eligible==1
histogram age if Eligible==0

tab MaritialStatus if Eligible==1
tab MaritialStatus if Eligible==0


/*Check Eligibity Status for 3 years*/

cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV"

insheet using "SAGE_HHWEIGHTSV2.csv",clear
tabulate eligilitystatus targetingmethod

cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2013\UGA_2013_SAGE-ML_v01_M_CSV"

insheet using "SAGE_HHWEIGHTSV2.csv",clear
tabulate eligilitystatus targetingmethod

cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2014\UGA_2014_SAGE-EL_v01_M_CSV"

insheet using "SAGE_HHWEIGHTSV2.csv",clear
tabulate targetingmethod



/*we observe that our population is rather young*/

replace hh1_q5=. if hh1_q5>2   
replace hh1_q19=. if hh1_q19>2


/*create disabled binary variable*/

generate disabled=.
replace disabled=1 if hh1_q19==1
replace disabled=0 if hh1_q19==2

summarize disabled


