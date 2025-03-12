clear all
import excel using "file path", firstrow

replace Import = "." if Import == "NA"
replace Export = "." if Export == "NA"

destring Import, replace
destring Export, replace
destring Censorship, replace

replace China_dep = "." if China_dep == "#VALUE!"
replace China_dep = "." if China_dep == "#DIV/0!"
destring China_dep, replace

replace GDP_grow = "." if GDP_grow == "NA"
destring GDP_grow, replace
replace Distance = "." if Distance == "NA"
destring Distance, replace

replace GDP = "." if GDP == "NA" 
destring GDP, replace
replace Polity = "." if Polity == "NA" 
destring Polity, replace

replace confucius = "." if confucius == "N/A" 
destring confucius, replace
replace content_partner = "." if content_partner == "N/A" 
destring content_partner, replace

encode country, gen(country_id)
xtset country_id year
tab country_id

* Initialize the term variable to missing values to start clean
gen term = .

replace term = 1 if year >= 1993 & year <= 1997
replace term = 2 if year >= 1998 & year <= 2002
replace term = 3 if year >= 2003 & year <= 2007
replace term = 4 if year >= 2008 & year <= 2012
replace term = 5 if year >= 2013 & year <= 2017
replace term = 6 if year >= 2018 & year <= 2023


* leader's nominal*
gen leader_name = ""
replace leader_name = "Jiang Zemin" if term == 1
replace leader_name = "Jiang Zemin" if term == 2
replace leader_name = "Hu Jintao" if term == 3
replace leader_name = "Hu Jintao" if term == 4
replace leader_name = "Xi Jinping" if term == 5
replace leader_name = "Xi Jinping" if term == 6
tabulate leader_name
tabulate leader_name, generate(leader_dummy)

rename leader_dummy1 Hu
rename leader_dummy2 Jiang
rename leader_dummy3 Xi

* Jiang as Reference*

gen secondterm = .
replace secondterm = 0 if term == 1 | term == 3 | term == 5 
replace secondterm = 1 if term == 2 | term == 4 | term == 6
tabulate secondterm


* Logging econmic variables
generate log_GDP = log(GDP)
generate log_Export = log(Export)
generate log_Import = log(Import)

* Using the lag operator (L.) to create lagged variables
gen log_GDP_lag = L.log_GDP
gen FTA_lag = L.FTA
gen log_Import_lag = L.log_Import
gen log_Export_lag = L.log_Export
gen MID_lag = L.MID
gen TIES_lag = L.TIES
gen CSP_lag = L.CSP
gen G20_lag = L.G20
gen G8_lag = L.G8
gen BRI_lag = L.BRI
gen BRICS_lag = L.BRICS

nbreg article_count i.secondterm##Xi Hu log_GDP_lag FTA_lag log_Import_lag log_Export_lag president_visit premier_visit BRI_lag MID TIES CSP_lag G8_lag BRICS_lag Distance VDem Olympics, vce(cluster country)

regress article_count i.secondterm##Xi Hu log_GDP_lag FTA_lag log_Import_lag log_Export_lag president_visit premier_visit BRI_lag MID TIES CSP_lag G8_lag BRICS_lag Distance VDem Olympics, vce(cluster country)
