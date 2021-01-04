cd "C:\Users\David Mengelle\Desktop\Uganda database\Data\Data 2012\UGA_2012_SAGE-BL_v01_M_CSV"

/* I import the data from int_access_health file and I check that it corresponds with the one you have described (n=21 257) */
insheet using "int_access_health.csv"

/*create disabled variable*/
tabulate hh1_q19
summarize hh1_q19
generate disabled=.
replace disabled=1 if hh1_q19==1
replace disabled=0 if hh1_q19==2

/*create  variable*/






/*I started renaming some variables
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
