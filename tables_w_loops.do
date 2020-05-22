
foreach i of varlist cooking_fuel floor_material type_toilet {
	replace `i'=. if `i'==97
}


forvalues k = 1/10 {
	display "`k'"
}

foreach z of numlist 1/10 {
	display "`z'"
}


local q 1
	while `q' <= 10 {
	display "`q'"
	local q `++q'
}


forvalues k = 10/1 {
	display `k'
}

foreach r of numlist 10/1 {
	display "`r'"
}

local t 10
while `t' >= 1 {
	display "`t'"
	local t `--t'
}


global letters "A" "B" "C" "D" "E"
forvalues i=1/5 {
	local letter_i: word `i' of `letters'
	display "`letter_i'"
}

foreach i of global letters {
	display "`i'"
}


clear
set obs 100
set seed 10101
foreach num of numlist 1/4 {
	gen x`num'var = runiform()
}

gen sum = 0
foreach var of varlist x1var x2var x3var x4var {
	quietly replace sum=sum+`var'
}


foreach var of global numerics {
	quietly sum `var'
	display "`var' -- " r(mean)
}



clear matrix
forvalues i = 1/6 {
	mat A`i' = J(11, 1, .)
}

local n 1
foreach var of global numerics {
	ttest `var', by(older)
	mat A1[`n',1]= `r(N_1)'
	mat A2[`n',1]= `r(N_2)'
	mat A3[`n',1]= `r(mu_1)'
	mat A4[`n',1]= `r(mu_2)'
	mat A5[`n',1]= `r(mu_1)' - `r(mu_2)'
	mat A6[`n',1]= `r(p)'
	local ++n
	display `n'
}

//for first var, it's put in row 1, col 1 of A1; for second var, row 2, col 1 of A2, and so on.

matrix rownames A1 = "Census Region" "b" "c" "d" "e" "f" "g" "h" "i" "j"
frmttable, statmat(A1) replace sdec(0) title(Table 1: Descriptives) ctitles("","N(0)") note("")
frmttable, statmat(A2) replace sdec(0) merge ctitles("N (1) ")
frmttable, statmat(A3) replace sdec(2) merge ctitles("Mean (0)")
frmttable, statmat(A4) replace sdec(2) merge ctitles("Mean (1)") 
frmttable, statmat(A5) replace sdec(3) merge ctitles("Difference in means") 
frmttable, statmat(A6) replace sdec(3) merge ctitles("p-value of difference in means")
frmttable using "Descriptives.doc", replay replace


























