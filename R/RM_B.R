RM_B = function(estado, from = 500, to = 2500, by = 500, n.nomes = 5) {

  if(estado == "ES") {

    data %>%
      filter(abbrev_state == estado) %>%
      ggplot(aes(geometry = geom,
                 label = ifelse(rank(renda_media_BRANCO) <= n.nomes | rank(-renda_media_BRANCO) <= n.nomes , paste(name_muni, scales::dollar(renda_media_BRANCO), sep = "\n"), NA),
                 fill = renda_media_BRANCO)) +
      geom_sf() +
      ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
      coord_sf(xlim = c(-42, -39.5)) +
      scale_fill_continuous(breaks = seq(from = from, to = to , by = by),
                            limits = c(0, to + 500), type = "viridis") +
      guides(fill = guide_colourbar(title = "renda média familiar",
                                    title.position = "top",
                                    title.hjust = 0.5)) +
      labs(y = "PRETOS & PARDOS") +
      theme_void() +
      theme(legend.position = "bottom",
            legend.key.width = unit(1.5, "cm"),
            axis.title.y = element_text(angle = 90))

  } else {

    data %>%
      filter(abbrev_state == estado) %>%
      ggplot(aes(geometry = geom,
                 label = ifelse(rank(renda_media_BRANCO) <= n.nomes | rank(-renda_media_BRANCO) <= n.nomes , paste(name_muni, scales::dollar(renda_media_BRANCO), sep = "\n"), NA),
                 fill = renda_media_BRANCO)) +
      geom_sf() +
      ggrepel::geom_label_repel(color = "white", stat = "sf_coordinates") +
      scale_fill_continuous(breaks = seq(from = from, to = to , by = by),
                            limits = c(0, to + 500), type = "viridis") +
      guides(fill = guide_colourbar(title = "renda média familiar",
                                    title.position = "top",
                                    title.hjust = 0.5)) +
      labs(y = "PRETOS & PARDOS") +
      theme_void() +
      theme(legend.position = "bottom",
            legend.key.width = unit(1.5, "cm"),
            axis.title.y = element_text(angle = 90))

  }

}
