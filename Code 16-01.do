cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV"

/* I import the data from int_access_health file and I check that it corresponds with the one you have described (n=21 257) */

/*merge both databases */
insheet using "int_cohesion_empow.csv",clear
sort hhid
save "int_cohesion_empow.dta", replace

insheet using "int_access_health.csv",clear
sort hhid
merge m:1 hhid using "int_cohesion_empow.dta"
drop _merge

summarize

histogram hh1_q2, discrete

/*cleaning misingvalues database*/

local varlist "hh1_q2 hh2_q3 hh2_q4 hh2_q5 hh2_q7 hh2_q8 hh2_q9 hh2_q10 hh2_q11 hh4_q2 hh4_q3 hh4_q4 hh4_q5 hh4_q6 hh4_q7 hh4_q9 hh4_q10 hh4_q11"
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


/* merge the above database with the eligilitystatus database (not working)

insheet using "SAGE_HHWEIGHTSV2.csv",clear
sort hhid
save "SAGE_HHWEIGHTSV2.dta",replace

insheet using"applied.dta",clear
merge m:1 hhid using "SAGE_HHWEIGHTSV2.dta"
drop _merge
*/


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


/*cleaning hh1_q5 variable*/

replace hh1_q5=. if hh1_q5>2   
replace hh1_q19=. if hh1_q19>2 


/*create disabled binary variable*/

generate disabled=.
replace disabled=1 if hh1_q19==1
replace disabled=0 if hh1_q19==2

summarize disabled






/*renaming some variables (not finished)
rename hh1_q2 age
rename hh1_q5 sex
rename hh1_q6 Famrelation
rename hh1_q19 Disability
rename hh2_q3 School 
rename hh2_q4 PresentGrade
rename hh2_q5 PastGrade
rename hh2_q7 DaysMiss
rename hh2_q8 ReasonMiss
rename hh2_q9 ReasonNotSchool
rename hh2_q10 HighestGrade
rename hh2_q11 ReasonLeave
rename hh4_q2
rename hh4_q3
rename hh4_q4
rename hh4_q5
rename hh4_q6
rename hh4_q7
rename hh4_q9
rename hh4_q10
rename hh4_q11
rename hh4_q16
rename hh4_q17
rename hh4_q18
rename hh4_q19
rename hh4_q20
*/
