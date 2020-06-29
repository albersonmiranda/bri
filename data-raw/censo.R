### CENSO ###


# data from http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm


# 1. PACOTES ----


library(tidyverse)


# 2. IMPORT ----

url = list(
  `1991` = "ftp://ftp.datasus.gov.br/dissemin/publicos/ibge/censo/rendabr91.zip",
  `2000` = "ftp://ftp.datasus.gov.br/dissemin/publicos/ibge/censo/rendabr00.zip",
  `2010` = "ftp://ftp.datasus.gov.br/dissemin/publicos/ibge/censo/rendabr10.zip"
)

censo = lapply(url, function (x){

  temp = tempfile()
  download.file(x, temp)
  temp = unzip(temp)

  data = foreign::read.dbf(temp)

  data = data %>%
    mutate(across(where(is.integer), as.numeric),
           CORRACA = case_when(CORRACA == 1 ~ "BRANCO",
                               CORRACA == 2 ~ "PRETO",
                               CORRACA == 3 ~ "AMARELO",
                               CORRACA == 4 ~ "PARDO",
                               CORRACA == 5 ~ "INDIGENA",
                               CORRACA == 0 ~ "SEM DECLARACAO"),
           RM = NUMRENDA / DENRENDA,
           POB = NUMPOBRES / DENRENDA,
           POBX = NUMPOBRESX / DENRENDA,
           DSMPRG = NUMDESOCUP / DENDESOCUP) %>%
    select(MUNCOD, CORRACA,
           NUMRENDA, DENRENDA, RM,
           NUMPOBRES, NUMPOBRESX, POB, POBX,
           NUMDESOCUP, DENDESOCUP, DSMPRG) %>%
    pivot_wider(id_cols = c(MUNCOD),
                names_from = CORRACA,
                values_from = c(NUMRENDA, DENRENDA, RM,
                                NUMPOBRES, NUMPOBRESX, POB, POBX,
                                NUMDESOCUP, DENDESOCUP, DSMPRG))

})


# 3. EXPORT ----


usethis::use_data(censo, overwrite = TRUE)
