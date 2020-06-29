### Rais ###


# Script para acessar o banco de dados SQL com a Rais de cada estado e
# importá-los na mesma estrutura que os dados do Censo.
#
# Devido ao tamanho, não estou disponibilizando os arquivos estaduais na
# integra. Caso deseje utilizá-los, verifique as instruções no script .sql.


library(tidyverse)

con = DBI::dbConnect(
  RMySQL::MySQL(),
  dbname = "bri",
  user = "root",
  host = "localhost",
  password = rstudioapi::askForPassword())

tab = DBI::dbListTables(con)

tab_rais_2017 = tab[str_detect(tab, "rais2017") == TRUE]

rais_2017 = lapply(setNames(tab_rais_2017, tab_rais_2017), function (x){

  x = tbl(con, paste(x)) %>%
    group_by(muni_estab, raca) %>%
    mutate(rem_media_n = str_replace_all(rem_media_n, ",", "."),
           pobre = ifelse(str_replace_all(rem_media_sm, ",", ".") < 0.5, 1, 0),
           xpobre = ifelse(str_replace_all(rem_media_sm, ",", ".") < 0.25, 1, 0)) %>%
    summarise(RM = mean(rem_media_n, na.rm = TRUE),
              DENRENDA = n(),
              NUMPOBRES = sum(pobre),
              NUMPOBRESX = sum(xpobre)) %>%
    collect()

  x = x %>%
    mutate(raca = case_when(raca == "01" ~ "INDIGENA",
                            raca == "02" ~ "BRANCO",
                            raca == "04" ~ "PRETO",
                            raca == "06" ~ "AMARELO",
                            raca == "08" ~ "PARDO",
                            raca == "09" ~ "SEM DECLARACAO",
                            TRUE ~ "IGNORADO"),
           POB = NUMPOBRES / DENRENDA,
           POBX = NUMPOBRESX / DENRENDA) %>%
    pivot_wider(id_cols = c(muni_estab),
                names_from = raca,
                values_from = c(DENRENDA, RM,
                                NUMPOBRES, NUMPOBRESX, POB, POBX))

})

usethis::use_data(rais_2017, overwrite = TRUE)
