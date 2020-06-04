### CENSO ###


# O objetivo desse projeto é obter e visualizar
# a relação de pobreza e raça nos municípios do Brasil.
#
# Os dados foram obtidos em http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm


# 1. PACOTES ----


library(tidyverse)
library(patchwork)


# 2. IMPORT ----


# dados do IBGE
censo = foreign::read.dbf("data-raw/RENDABR10.dbf")
censo = censo %>%
  mutate(across(where(is.integer), as.numeric))

# verificando último ano disponível
ult = geobr::list_geobr() %>%
  filter(geography == "Municipality") %>%
  mutate(years = str_split(years, ", ")) %>%
  select(years) %>%
  unlist()

ult = as.numeric(ult[length(ult)][[1]])

# mapas
mapa = geobr::read_municipality(code_muni="all", year=ult) %>%
  mutate(code_muni = str_sub(code_muni, 1, 6))


# 3. DATA CLEANING ----


data = censo %>% inner_join(mapa, by = c("MUNCOD" = "code_muni"))

data = data %>%
  mutate(CORRACA = case_when(CORRACA == 1 ~ "BRANCO",
                             CORRACA == 2 ~ "PRETO",
                             CORRACA == 3 ~ "AMARELO",
                             CORRACA == 4 ~ "PARDO",
                             CORRACA == 5 ~ "INDIGENA",
                             CORRACA == 0 ~ "SEM DECLARACAO")) %>%
  select(abbrev_state, name_muni, CORRACA, DENRENDA, NUMRENDA, NUMPOBRES, NUMPOBRESX, geom) %>%
  mutate(renda_media = NUMRENDA/DENRENDA) %>%
  pivot_wider(id_cols = c(abbrev_state, name_muni, geom),
              names_from = CORRACA,
              values_from = c(DENRENDA, NUMRENDA, NUMPOBRES, NUMPOBRESX, renda_media)) %>%
  mutate(renda_media_NEGRA = (renda_media_PRETO*DENRENDA_PRETO+renda_media_PARDO*DENRENDA_PARDO)/(DENRENDA_PRETO+DENRENDA_PARDO))

# 4. DATA ----


censo_des = data
usethis::use_data(censo_des, overwrite = TRUE)
