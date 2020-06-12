### CENSO 2010 ###


# O objetivo desse projeto é obter e visualizar
# a relação de pobreza e raça nos municípios do Brasil.
#
# Os dados foram obtidos em http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm


# 1. PACOTES ----


library(tidyverse)


# 2. IMPORT ----


# dados do IBGE
censo_2010 = foreign::read.dbf("data-raw/censo/RENDABR10.dbf")
censo_2010 = censo_2010 %>%
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


censo_2010 = censo_2010 %>% inner_join(mapa, by = c("MUNCOD" = "code_muni")) %>%
  mutate(CORRACA = case_when(CORRACA == 1 ~ "BRANCO",
                             CORRACA == 2 ~ "PRETO",
                             CORRACA == 3 ~ "AMARELO",
                             CORRACA == 4 ~ "PARDO",
                             CORRACA == 5 ~ "INDIGENA",
                             CORRACA == 0 ~ "SEM DECLARACAO"),
         RM = NUMRENDA / DENRENDA,
         DSMPRG = NUMDESOCUP / DENDESOCUP) %>%
  select(abbrev_state, name_muni, CORRACA,
         NUMRENDA, DENRENDA, RM,
         NUMPOBRES, NUMPOBRESX,
         NUMDESOCUP, DENDESOCUP, DSMPRG,
         geom) %>%
  pivot_wider(id_cols = c(abbrev_state, name_muni, geom),
              names_from = CORRACA,
              values_from = c(NUMRENDA, DENRENDA, RM,
                              NUMPOBRES, NUMPOBRESX,
                              NUMDESOCUP, DENDESOCUP, DSMPRG))

# 4. DATA ----


usethis::use_data(censo_2010, overwrite = TRUE)
