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


* D)
use "Thorell_Lamers_HW2.dta", clear

* Vad var effekten av Stockholms trängselskatt på koldioxidutsläpp i Stockholms län? The varible we are intressed in is carbondioxid emissions
* We have a G of 2 
* We have a T of 20 from the years 1990-2010



* data
twoway                                ///
    (scatter co2 year if sthlm==1, connect(l)) ///
    (scatter co2 year if sthlm==0, connect(l)) ///
	 ,xline(2006.5) ///
    xtick(1990(1)2010, angle(70)) ///
    legend(label(1 "Stockholm") label(2 "Gothenburg")) ///
    graphregion(color(white))

* Delta
egen co2_s1 = mean(cond(sthlm==1, co2, .)), by(year)
egen co2_s0 = mean(cond(sthlm==0, co2, .)), by(year)

gen diff_co2 = co2_s1 - co2_s0 

scatter diff_co2 year if sthlm == 1, ///
    connect(l) ///
    xline(2006.5) ///
    xtick(1990(1)2010, angle(70)) ///
    title("Diff CO2 Stockholm - Gothenburg") ///
    graphregion(color(white))
	
* Regression

gen stockholm_post = sthlm*after
reg co2 sthlm after stockholm_post, r

* All coefficients are signifiacant
* α is gothenburg co2 with before 
* α1STHLM is the increase in co2 for stockholm
* γpost is after the tariff in Gothenburg(there is no tariff so the increase in co2)
* δ(STHLMgt × postt) is the effect of the tariff in stockholm