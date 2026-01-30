clear all

cd "C:\Users\sebib\Documents\GitHub\US_Congress\data"

* 1. Importar el CSV y guardar como .dta
import delimited "congress_trading_features.csv", clear varnames(1)
save "congress_trading_features.dta", replace

* 2. Importar el Excel de legisladores y guardar como .dta
* (cambiá "legislators_complete.xlsx" por el nombre exacto de tu archivo)
import excel "C:\Users\sebib\Documents\GitHub\US_Congress\data\info basica politicos\legislators_complete.xlsx", firstrow clear
save "legislators_complete.dta", replace
drop if bioguideid == ""
save "legislators_complete.dta", replace

* 3. Cargar la base de trading y hacer el merge
use "congress_trading_features.dta", clear

* Renombrar para que coincidan (si en el Excel se llama distinto)
* rename bioguideid BioGuideID

* Merge many-to-one
merge m:1 bioguideid using "legislators_complete.dta"

* Ver resultados
tab _merge

* Guardar base final
save "congress_merged.dta", replace

* ============================================
* 1. ELIMINAR VARIABLES DUPLICADAS
* ============================================
drop full_name 

* ============================================
* 2. CREAR VARIABLES NUMÉRICAS CON LABELS
* ============================================

* --- GENDER (0=Female, 1=Male) ---
gen male = .
replace male = 0 if gender == "F"
replace male = 1 if gender == "M"

label define male_lbl 0 "Female" 1 "Male"
label values male male_lbl
label variable male "Male legislator"

rename chamber chamber1
rename party party1

* --- CHAMBER (0=House, 1=Senate) ---
gen chamber = .
replace chamber = 0 if chamber1 == "House"
replace chamber= 1 if chamber1 == "Senate"

label define chamber_lbl 0 "House" 1 "Senate"
label values chamber chamber_lbl
label variable chamber "Chamber"

* --- PARTY (0=Democrat, 1=Republican, 2=Independent) ---
gen party = .
replace party = 0 if party1 == "D"
replace party = 1 if party1 == "R"
replace party = 2 if party1 == "I"

label define party_lbl 0 "Democrat" 1 "Republican" 2 "Independent"
label values party party_lbl
label variable party "Party affiliation"

* --- STATUS (limpiar mayúsculas) ---
replace status = "New" if status == "NEW"

* --- TYPE (redundante con chamber) ---
drop type

* ============================================
* 3. VERIFICAR
* ============================================
tab male
tab chamber_num
tab party_num