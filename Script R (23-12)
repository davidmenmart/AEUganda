# CREATE THE DATA BASE
RosterDF <- Individual_health_21257_obs[ ,c("hhid" ,"hh1_q2", "hh1_q5", "hh1_q6","hh1_q19" ,"hh2_q3", "hh2_q4","hh2_q5", "hh2_q7", "hh2_q8", "hh2_q9","hh2_q10", "hh2_q11", "hh4_q2","hh4_q3","hh4_q4","hh4_q5","hh4_q6", "hh4_q7","hh4_q9", "hh4_q10", "hh4_q11","hh4_q16", "hh4_q17", "hh4_q18", "hh4_q19", "hh4_q20")]

# RECODE HH1_q2 1 if female
RosterDF$hh1_q5 <- ifelse(RosterDF$hh1_q5 == 2,1,0)

# RECODE HH1_q19 1 if disabled
RosterDF$hh1_q19 <- ifelse(RosterDF$hh1_q19 == 1,1,0)

# RECODE HH2_q3 1 if went to formal school
RosterDF$hh2_q3 <- ifelse(RosterDF$hh2_q3 == c(2,3),1,0)
if (RosterDF$hh2_q3==2) RosterDF             #### à retaffer

# RECODE HH2_q3 {primary, secondary, university}

#REMOVE HH2_q7/8/9 (create a subsample for children) 

# RECODE HH2_q10 {primary, secondary, university} and remove NA after

# RECODE HH4_q2 1 if worked for payment outside the household
RosterDF$hh4_q2 <- ifelse(RosterDF$hh4_q2 == 1,1,0)

# RECODE HH4_q3 1 if worked for payment for the household
RosterDF$hh4_q3 <- ifelse(RosterDF$hh4_q3 == 1,1,0)

# RECODE HH4_q4 1 if worked for payment for the household
RosterDF$hh4_q4 <- ifelse(RosterDF$hh4_q4 == 1,1,0)

#RECODE SUM of hh4_q3 and hh4_q4 : if equal to 1 or 2, dummy equal to 1
RosterDF$WorkForHH<-ifelse(RosterDF$hh4_q3+RosterDF$hh4_q4>=1,1,0)

# RECODE HH4_q5 1 if worked for payment for the household
RosterDF$hh4_q5 <- ifelse(RosterDF$hh4_q5 == 1,1,0) #remove NA



