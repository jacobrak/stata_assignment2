// Data
use "Dadt_Arbesu_HW2", clear

* Simple regression
reg anc_share zulu, r 

**
// β is -.227468 lower if zulu = 1, meaning share of voters is less if zulu = 1
**

* Zulupost and DD
gen zulupost = zulu*post
reg anc_share zulu post zulupost, r 

**
// All coefficients are siginificant
// β0 = .7002732 the constant coefficient is 0.7 share of votes
// β1 = -.3128846 zulu = 1 decreases the share of votes by 0.31
// β2 = -.0246572 post decreases the share of votes by 0.024
// γ =  .2071297 zulu post increases the share of votes by 0.207
**

*Parellel data
gen Z2004 = zulu*(year==2004)
gen Z2006 = zulu*(year==2006)
gen year2006 = (year == 2006)

* dummy varible for year2006
reg anc_share zulu year2006 Z2004 Z2006 if year<2007, r

**
// δ1 is zulu effect year 2004
// δ is zulu effect year 2006
// We are doing this to check for parellel trends before the treatment
**

gen frac_post = frac_zulu*post
reg anc_share zulu post zulupost frac_post, r

* The paper investigates if aligning politics with cheifs map could increase vote share.
* We see an increase for the coefficients regarding zulupost and frac_post, so True


use "Thorell_Lamers_HW2.dta", clear

* Vad var effekten av Stockholms trängselskatt på koldioxidutsläpp i Stockholms län? The varible we are intressed in is carbondioxid emissions
* We have a G of 2 
* We have a T of 20 from the years 1990-2010

twoway ///
    (scatter y year if treated==0, connect(l)) ///
    (scatter y year if treated==1, connect(l)) ///
    , xline(2008.5) xlabel(`start_year'(1)`end_year', angle(70)) ///
    legend(label(1 "Not treated") label(2 "Treated")) t2(2000-2012) ///
	graphregion(color(white)) saving(x1.gph, replace)


