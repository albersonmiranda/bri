# Informações geográficas

# 1. PACOTES ----


library(tidyverse)


# 2. IMPORT ----


# verificando último ano disponível
ult = geobr::list_geobr() %>%
  filter(geography == "Municipality") %>%
  mutate(years = str_split(years, ", ")) %>%
  select(years) %>%
  unlist()

ult = as.numeric(ult[length(ult)][[1]])

# mapas
mapa = geobr::read_municipality(code_muni="all", year=ult) %>%
  mutate(code_muni = str_sub(code_muni, 1, 6)) %>%
  select(-code_state)

usethis::use_data(mapa, overwrite = TRUE)
