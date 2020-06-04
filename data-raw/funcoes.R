# 4. DATAVIZ ----


# 4.1 RENDA MÉDIA ----


# 4.1.1 ES ----
RM_P = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(rank(renda_media_NEGRA) <= 5 | rank(-renda_media_NEGRA) <= 5 , paste(name_muni, scales::dollar(renda_media_NEGRA), sep = "\n"), NA),
             fill = renda_media_NEGRA)) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(500, 1000, 1500, 2000, 2500), limits = c(0, 3000), type = "viridis") +
  labs(y = "PRETOS & PARDOS") +
  theme_void() +
  theme(legend.position = "none",
        axis.title.y = element_text(angle = 90))

RM_B = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(rank(renda_media_BRANCO) <= 5 | rank(-renda_media_BRANCO) <= 5 , paste(name_muni, scales::dollar(renda_media_BRANCO), sep = "\n"), NA),
             fill = renda_media_BRANCO)) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(500, 1000, 1500, 2000, 2500), limits = c(0, 3000), type = "viridis") +
  guides(fill = guide_colourbar(title = "renda média familiar",
                                title.position = "top",
                                title.hjust = 0.5)) +
  labs(y = "BRANCOS") +
  theme_void() +
  theme(legend.position = "bottom",
        legend.key.width = unit(1.5, "cm"),
        axis.title.y = element_text(angle = 90))

# 1300 x 1000
RM_P + RM_B +
  plot_layout(guides = "collect") +
  plot_annotation(title = "DESIGUALDADE DE RENDA",
                  subtitle = "PRETA/PARDA VERSUS BRANCA",
                  caption = "dados: IBGE/censo 2010 | elaboração: @albersonmiranda",
                  theme = theme(legend.position = "bottom",
                                plot.title = element_text(size = 18))) &
  theme(text = element_text(family = "serif"),
        panel.background = element_rect(fill = "aliceblue"))


# 4.1.2 OUTROS ESTADOS ----


RM_P = data %>%
  filter(abbrev_state == "PI") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(rank(renda_media_NEGRA) <= 5 | rank(-renda_media_NEGRA) <= 5 , paste(name_muni, scales::dollar(renda_media_NEGRA), sep = "\n"), NA),
             fill = (renda_media_PRETO*DENRENDA_PRETO+renda_media_PARDO*DENRENDA_PARDO)/(DENRENDA_PRETO+DENRENDA_PARDO))) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  scale_fill_continuous(breaks = c(250, 500, 750, 1000, 1250), limits = c(0, 1500), type = "viridis") +
  labs(y = "PRETOS & PARDOS") +
  theme_void() +
  theme(legend.position = "none",
        axis.title.y = element_text(angle = 90))

RM_B = data %>%
  filter(abbrev_state == "PI") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(rank(renda_media_BRANCO) <= 5 | rank(-renda_media_BRANCO) <= 5 , paste(name_muni, scales::dollar(renda_media_BRANCO), sep = "\n"), NA),
             fill = renda_media_BRANCO)) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  scale_fill_continuous(breaks = c(250, 500, 750, 1000, 1250), limits = c(0, 1500), type = "viridis") +
  guides(fill = guide_colourbar(title = "renda média familiar",
                                title.position = "top",
                                title.hjust = 0.5)) +
  labs(y = "BRANCOS") +
  theme_void() +
  theme(legend.position = "bottom",
        legend.key.width = unit(1.5, "cm"),
        axis.title.y = element_text(angle = 90))

# 1300 x 1000
RM_P + RM_B +
  plot_layout(guides = "collect") +
  plot_annotation(title = "DESIGUALDADE DE RENDA",
                  subtitle = "PRETA/PARDA VERSUS BRANCA",
                  caption = "dados: IBGE/censo 2010 | elaboração: @albersonmiranda",
                  theme = theme(legend.position = "bottom",
                                plot.title = element_text(size = 18))) &
  theme(text = element_text(family = "serif"),
        panel.background = element_rect(fill = "aliceblue"))

# 4.2 NÚMERO DE POBRES ----
RM_P = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(DENRENDA_BRANCO+DENRENDA_PRETO+DENRENDA_PARDO > 30000, name_muni, NA),
             fill = (NUMPOBRES_PRETO+NUMPOBRES_PARDO)/(DENRENDA_PRETO+DENRENDA_PARDO))) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6), limits = c(0, 0.7), type = "viridis") +
  labs(y = "PRETOS & PARDOS") +
  theme_void() +
  theme(legend.position = "none",
        axis.title.y = element_text(angle = 90))

RM_B = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(DENRENDA_BRANCO+DENRENDA_PRETO+DENRENDA_PARDO > 30000, name_muni, NA),
             fill = NUMPOBRES_BRANCO/DENRENDA_BRANCO)) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6), limits = c(0, 0.7), type = "viridis") +
  guides(fill = guide_colourbar(title = "% pobres",
                                title.position = "top",
                                title.hjust = 0.5)) +
  labs(y = "BRANCOS") +
  theme_void() +
  theme(legend.position = "bottom",
        legend.key.width = unit(1.5, "cm"),
        axis.title.y = element_text(angle = 90))

# 1300 x 1000
RM_P + RM_B +
  plot_layout(guides = "collect") +
  plot_annotation(title = "DESIGUALDADE DE RENDA",
                  subtitle = "PRETA/PARDA VERSUS BRANCA",
                  caption = "dados: IBGE/censo 2010 | elaboração: @albersonmiranda",
                  theme = theme(legend.position = "bottom",
                                plot.title = element_text(size = 18))) &
  theme(text = element_text(family = "serif"),
        panel.background = element_rect(fill = "aliceblue"))


# 4.2 EXTREMA POBREZA ----
RM_P = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(DENRENDA_BRANCO+DENRENDA_PRETO+DENRENDA_PARDO > 30000, name_muni, NA),
             fill = (NUMPOBRESX_PRETO+NUMPOBRESX_PARDO)/(DENRENDA_PRETO+DENRENDA_PARDO))) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(0.1, 0.2, 0.3), limits = c(0, 0.4), type = "viridis") +
  labs(y = "PRETOS & PARDOS") +
  theme_void() +
  theme(legend.position = "none",
        axis.title.y = element_text(angle = 90))

RM_B = data %>%
  filter(abbrev_state == "ES") %>%
  ggplot(aes(geometry = geom,
             label = ifelse(DENRENDA_BRANCO+DENRENDA_PRETO+DENRENDA_PARDO > 30000, name_muni, NA),
             fill = NUMPOBRESX_BRANCO/DENRENDA_BRANCO)) +
  geom_sf() +
  ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
  coord_sf(xlim = c(-42, -39.5)) +
  scale_fill_continuous(breaks = c(0.1, 0.2, 0.3), limits = c(0, 0.4), type = "viridis") +
  guides(fill = guide_colourbar(title = "% extrema pobreza",
                                title.position = "top",
                                title.hjust = 0.5)) +
  labs(y = "BRANCOS") +
  theme_void() +
  theme(legend.position = "bottom",
        legend.key.width = unit(1.5, "cm"),
        axis.title.y = element_text(angle = 90))

# 1300 x 1000
RM_P + RM_B +
  plot_layout(guides = "collect") +
  plot_annotation(title = "DESIGUALDADE DE RENDA",
                  subtitle = "PRETA/PARDA VERSUS BRANCA",
                  caption = "dados: IBGE/censo 2010 | elaboração: @albersonmiranda",
                  theme = theme(legend.position = "bottom",
                                plot.title = element_text(size = 18))) &
  theme(text = element_text(family = "serif"),
        panel.background = element_rect(fill = "aliceblue"))

