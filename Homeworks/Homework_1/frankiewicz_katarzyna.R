###ZADANIE DOMOWE ----
# Funkcja kt�ra liczy proporcje brakuj�cych warto�ci dla ka�dej kolumny:

fun <- function(input_vec){
  length(input_vec[is.na(input_vec)])/length(input_vec)
}
## base
sapply(gas_base, fun)
## tidyverse
summarise_all(gas_tv, fun)
## data.table
gas_dt[, lapply(.SD, fun)]
