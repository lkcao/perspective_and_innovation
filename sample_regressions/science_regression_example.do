cd "/project/jevans/likun/cognitive_project/stata_files"
use "science_short.dta",replace
//This dataset is shared through: https://drive.google.com/file/d/1ti5DvSRM-USYtc0jmE9fLJhoM8EcAtJf/view?usp=sharing

recode mean_experience previous_rate mean_performance (.=0)
winsor2 full_team_size, cuts(0,99.9)
winsor2 mean_experience, cuts(0,99.9)
winsor2 mean_performance, cuts(0,99.9)
gen log_experience=log(mean_experience+1)
replace perspective_diversity1=log(perspective_diversity1+1)
replace bdiversity=log(bdiversity+1)

nbreg citing_count perspective_diversity1 bdiversity log_experience i.year i.full_team_size_w i.single_field, vce(cluster single_field)
est store m1
nbreg citing_count perspective_diversity1 bdiversity newbie_rate previous_rate log_experience i.year i.full_team_size_w i.single_field,  vce(cluster single_field)
est store m2

display e(df_m)
display e(N)-e(df_m)-1
