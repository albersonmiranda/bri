#' Plotar grafico de renda media branca x preta
#'
#' Essa funçao plota graficos de renda media per capita por etnia.
#'
#' @import patchwork
#' @import sf
#' @import ggplot2
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom purrr reduce
#' @export
#'
#' @param estado String. O estado a ser plotado.
#' @param etnia String. As etnias a serem plotadas. Cada etnia gera um
#'   objeto ggplot2 que e composto usando o patchwork.
#' @param n_nomes Integer. A quantidade de municipios a serem passados ao
#'   geom_label(). Note que a quantidade refere-se tanto aos
#'   municipios de menor e maior renda, de forma que, no total, serao exibidos
#'   o dobro de nomes informados.
#' @param p_nomes Integer. A populaçao minima no municipio de pessoas de cada
#'   etnia selecionada para que o nome do municipio seja exibido
#'   pelo geom_label().
#' @param from,to,by Integer. Valores a serem passados a seq() para criar a
#'   colorbar. Recomenda-se utilizar valores que representem os minimos e
#'   maximos exibidos.

r_m = function(estado,
               from = 500, to = 2500, by = 500,
               n_nomes = 5, p_nomes = 0,
               etnia = c("PRETO", "BRANCO", "PARDO", "INDIGENA", "AMARELO"),
               autor = NULL, titulo = NULL, subtitulo = NULL) {

  data = data_2010 %>%
    filter(abbrev_state == estado) %>%
    select(abbrev_state,
           name_muni,
           geom,
           "PRETO" = RM_PRETO,
           "BRANCO" = RM_BRANCO,
           "PARDO" = RM_PARDO,
           "INDIGENA" = RM_INDIGENA,
           "AMARELO" = RM_AMARELO,
           DENRENDA_PRETO,
           DENRENDA_BRANCO,
           DENRENDA_PARDO,
           DENRENDA_INDIGENA,
           DENRENDA_AMARELO)

  plots = lapply(etnia, function(etn) {

    pops = case_when(etn == "PRETO" ~ "DENRENDA_PRETO",
                     etn == "BRANCO" ~ "DENRENDA_BRANCO",
                     etn == "PARDO" ~ "DENRENDA_PARDO",
                     etn == "INDIGENA" ~ "DENRENDA_INDIGENA",
                     etn == "AMARELO" ~ "DENRENDA_AMARELO")

    plot = data %>%
      ggplot(
        aes(geometry = geom,
            fill = get(etn),
            label = paste(name_muni, scales::dollar(get(etn)), sep = "\n"))) +
      geom_sf() +
      ggrepel::geom_label_repel(
        data = data %>%
          arrange(get(etn)) %>%
          filter(!is.na(get(etn))) %>%
          filter(get(pops) >= p_nomes) %>%
          filter(row_number() %in% 1:n_nomes |
                   row_number() %in%
                   (length(get(etn)) - n_nomes + 1):(length(get(etn)))),
        color = "white", stat = "sf_coordinates") +
      scale_fill_continuous(breaks = seq(from = from, to = to, by = by),
                            limits = c(from - by, to + by), type = "viridis") +
      labs(y = etn) +
      theme_void() +
      theme(legend.position = "none",
            axis.title.y = element_text(angle = 90))

    if (estado == "ES") {

      plot + coord_sf(xlim = c(-42, -39.5))

    } else{

      plot

    }
  })

  reduce(plots, `+`) +
    theme(legend.position = "bottom",
          legend.key.width = unit(1.5, "cm"),
          axis.title.y = element_text(angle = 90)) +
    guides(fill = guide_colourbar(title = "renda media familiar",
                                  title.position = "top",
                                  title.hjust = 0.5)) +
    plot_layout(guides = "collect") +
    plot_annotation(
      title = titulo,
      subtitle = subtitulo,
      caption = paste("dados: IBGE/censo 2010 |",
                      "elaborado por:",
                      autor),
      theme = theme(legend.position = "bottom",
                    plot.title = element_text(size = 18))) &
    theme(text = element_text(family = "serif"),
          panel.background = element_rect(fill = "aliceblue"))

}
