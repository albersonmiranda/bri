RM_P = function(estado, from = 500, to = 2500, by = 500, n.nomes = 5) {

  if(estado == "ES") {

    data %>%
      filter(abbrev_state == estado) %>%
      ggplot(aes(geometry = geom,
                 label = ifelse(rank(renda_media_NEGRA) <= n.nomes | rank(-renda_media_NEGRA) <= n.nomes , paste(name_muni, scales::dollar(renda_media_NEGRA), sep = "\n"), NA),
                 fill = renda_media_NEGRA)) +
      geom_sf() +
      ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
      coord_sf(xlim = c(-42, -39.5)) +
      scale_fill_continuous(breaks = seq(from = from, to = to , by = by),
                            limits = c(0, to + 500), type = "viridis") +
      labs(y = "PRETOS & PARDOS") +
      theme_void() +
      theme(legend.position = "none",
            axis.title.y = element_text(angle = 90))

  } else {

    data %>%
      filter(abbrev_state == estado) %>%
      ggplot(aes(geometry = geom,
                 label = ifelse(rank(renda_media_NEGRA) <= n.nomes | rank(-renda_media_NEGRA) <= n.nomes , paste(name_muni, scales::dollar(renda_media_NEGRA), sep = "\n"), NA),
                 fill = renda_media_NEGRA)) +
      geom_sf() +
      ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
      scale_fill_continuous(breaks = seq(from = from, to = to , by = by),
                            limits = c(0, to + 500), type = "viridis") +
      labs(y = "PRETOS & PARDOS") +
      theme_void() +
      theme(legend.position = "none",
            axis.title.y = element_text(angle = 90))

  }

}
