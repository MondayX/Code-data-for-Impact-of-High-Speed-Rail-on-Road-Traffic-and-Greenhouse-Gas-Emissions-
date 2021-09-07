

****Table 1: Baseline Estimates
**column 1 - 4
use road_highway_pair, clear
reghdfe lnvol_passenger connect_pairactual, ab(road_year citypair_actual) vce(cl origin destination)
reghdfe lnvol_passenger connect_pairactual, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
reghdfe lnvol_goods connect_pairactual, ab(road_year citypair_actual) vce(cl origin destination)
reghdfe lnvol_goods connect_pairactual, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
**column 5 - 8
use road_ntnlrd_pair, clear
reghdfe lnvol_passenger connect_pairactual, ab(road_year citypair_actual) vce(cl origin destination)
reghdfe lnvol_passenger connect_pairactual, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
reghdfe lnvol_goods connect_pairactual, ab(road_year citypair_actual) vce(cl origin destination)
reghdfe lnvol_goods connect_pairactual, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)



****Figure 2: Event Study
**a: highway passenger
use road_highway_pair, clear
tab year_period
replace year_period=-4 if year_period<-4 & year_period!=.
replace year_period=4 if year_period>4 & year_period!=.
tab year_period, gen(year_period)
forvalues i = 1/9{
replace year_period`i'=0 if year_period`i'==.
}
bysort citypair_actual: gen a=_N
order a
tab a
keep if a==7
reghdfe lnvol_passenger year_period1-year_period3 year_period5-year_period9, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
mat se = e(V)
forvalues i = 1/3{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i', `i'])
}
forvalues i = 5/9{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i'-1, `i'-1])
}
keep coef* se*
duplicates drop
gen id = 1
reshape long coef se, i(id) j(period)
gen high=coef + 1.96 * se
gen low=coef - 1.96 * se
replace period=period-5
gen scax=-1 if period==0
gen scay=0 if period==0
gen blankx=-5 if period==0
gen blanky=0 if period==0
replace blankx=5 if period==1
replace blanky=0 if period==1
tw (rcap low high period, color("86 181 240")) ///
(sca coef period, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca scay scax, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca blanky blankx, msize(medsmall) color(none) msymbol(D)), ///
ytitle("Effect on highway passenger traffic", size(medsmall)) ///
xtitle("Number of years before and after the HSR connection", size(medsmall)) ///
xscale(titlegap(small)) yscale(titlegap(small)) legend(off) ///
ylabel(, format(%9.2f) labsize(medsmall) angle(0) nogrid) ///
xlabel(-4 "<= -4" -3 "-3" -2 "-2" -1 "-1" 0 "0" 1 "1" 2 "2" 3 "3" 4 ">= 4", labsize(medsmall)) xmtick(-4(1)4) ///
yline(0, lcolor(black) lpattern(dash)) ///
xline(0, lcolor(dkorange) lpattern(dash)) ///
text(0.1 1.5 "HSR connection", size(medsmall)) ///
graphregion(color(white)) plotregion(style(outline))

**b: highway goods
use road_highway_pair, clear
tab year_period
replace year_period=-4 if year_period<-4 & year_period!=.
replace year_period=4 if year_period>4 & year_period!=.
tab year_period, gen(year_period)
forvalues i = 1/9{
replace year_period`i'=0 if year_period`i'==.
}
bysort citypair_actual: gen a=_N
order a
tab a
keep if a==7
reghdfe lnvol_goods year_period1-year_period3 year_period5-year_period9, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
mat se = e(V)
forvalues i = 1/3{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i', `i'])
}
forvalues i = 5/9{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i'-1, `i'-1])
}
keep coef* se*
duplicates drop
gen id = 1
reshape long coef se, i(id) j(period)
gen high=coef + 1.96 * se
gen low=coef - 1.96 * se
replace period=period-5
gen scax=-1 if period==0
gen scay=0 if period==0
gen blankx=-5 if period==0
gen blanky=0 if period==0
replace blankx=5 if period==1
replace blanky=0 if period==1
tw (rcap low high period, color("86 181 240")) ///
(sca coef period, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca scay scax, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca blanky blankx, msize(medsmall) color(none) msymbol(D)), ///
ytitle("Effect on highway goods traffic", size(medsmall)) ///
xtitle("Number of years before and after the HSR connection", size(medsmall)) ///
xscale(titlegap(small)) yscale(titlegap(small)) legend(off) ///
ylabel(, format(%9.2f) labsize(medsmall) angle(0) nogrid) ///
xlabel(-4 "<= -4" -3 "-3" -2 "-2" -1 "-1" 0 "0" 1 "1" 2 "2" 3 "3" 4 ">= 4", labsize(medsmall)) xmtick(-4(1)4) ///
yline(0, lcolor(black) lpattern(dash)) ///
xline(0, lcolor(dkorange) lpattern(dash)) ///
text(0.1 1.5 "HSR connection", size(medsmall)) ///
graphregion(color(white)) plotregion(style(outline))

**c: national road passenger
use road_ntnlrd_pair, clear
tab year_period
replace year_period=-4 if year_period<-4 & year_period!=.
replace year_period=4 if year_period>4 & year_period!=.
tab year_period, gen(year_period)
forvalues i = 1/9{
replace year_period`i'=0 if year_period`i'==.
}
bysort citypair_actual: gen a=_N
order a
tab a
keep if a==7
reghdfe lnvol_passenger year_period1-year_period3 year_period5-year_period9, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
mat se = e(V)
forvalues i = 1/3{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i', `i'])
}
forvalues i = 5/9{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i'-1, `i'-1])
}
keep coef* se*
duplicates drop
gen id = 1
reshape long coef se, i(id) j(period)
gen high=coef + 1.96 * se
gen low=coef - 1.96 * se
replace period=period-5
gen scax=-1 if period==0
gen scay=0 if period==0
gen blankx=-5 if period==0
gen blanky=0 if period==0
replace blankx=5 if period==1
replace blanky=0 if period==1
tw (rcap low high period, color("86 181 240")) ///
(sca coef period, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca scay scax, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca blanky blankx, msize(medsmall) color(none) msymbol(D)), ///
ytitle("Effect on ordinary national road passenger traffic", size(medsmall)) ///
xtitle("Number of years before and after the HSR connection", size(medsmall)) ///
xscale(titlegap(small)) yscale(titlegap(small)) legend(off) ///
ylabel(, format(%9.2f) labsize(medsmall) angle(0) nogrid) ///
xlabel(-4 "<= -4" -3 "-3" -2 "-2" -1 "-1" 0 "0" 1 "1" 2 "2" 3 "3" 4 ">= 4", labsize(medsmall)) xmtick(-4(1)4) ///
yline(0, lcolor(black) lpattern(dash)) ///
xline(0, lcolor(dkorange) lpattern(dash)) ///
text(-0.3 1.5 "HSR connection", size(medsmall)) ///
graphregion(color(white)) plotregion(style(outline))
**d: national road goods
use road_ntnlrd_pair, clear
tab year_period
replace year_period=-4 if year_period<-4 & year_period!=.
replace year_period=4 if year_period>4 & year_period!=.
tab year_period, gen(year_period)
forvalues i = 1/9{
replace year_period`i'=0 if year_period`i'==.
}
bysort citypair_actual: gen a=_N
order a
tab a
keep if a==7
reghdfe lnvol_goods year_period1-year_period3 year_period5-year_period9, ab(road_year citypair_actual y_origin_prov y_destination_prov) vce(cl origin destination)
mat se = e(V)
forvalues i = 1/3{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i', `i'])
}
forvalues i = 5/9{
gen coef`i' = _b[year_period`i']
gen se`i' = sqrt(se[`i'-1, `i'-1])
}
keep coef* se*
duplicates drop
gen id = 1
reshape long coef se, i(id) j(period)
gen high=coef + 1.96 * se
gen low=coef - 1.96 * se
replace period=period-5

gen scax=-1 if period==0
gen scay=0 if period==0
gen blankx=-5 if period==0
gen blanky=0 if period==0
replace blankx=5 if period==1
replace blanky=0 if period==1
tw (rcap low high period, color("86 181 240")) ///
(sca coef period, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca scay scax, msize(medsmall) color("86 181 240") msymbol(D)) ///
(sca blanky blankx, msize(medsmall) color(none) msymbol(D)), ///
ytitle("Effect on ordinary national road goods traffic", size(medsmall)) ///
xtitle("Number of years before and after the HSR connection", size(medsmall)) ///
xscale(titlegap(small)) yscale(titlegap(small)) legend(off) ///
ylabel(, format(%9.2f) labsize(medsmall) angle(0) nogrid) ///
xlabel(-4 "<= -4" -3 "-3" -2 "-2" -1 "-1" 0 "0" 1 "1" 2 "2" 3 "3" 4 ">= 4", labsize(medsmall)) xmtick(-4(1)4) ///
yline(0, lcolor(black) lpattern(dash)) ///
xline(0, lcolor(dkorange) lpattern(dash)) ///
text(-0.2 -1.5 "HSR connection", size(medsmall)) ///
graphregion(color(white)) plotregion(style(outline))



