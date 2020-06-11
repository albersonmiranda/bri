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
#' @param fonte String. Fonte de dados utilizada. Atualmente disponivel o
#'   Censo do IBGE.
#' @param ref String. Ano de referencia da coleta de dados. Atualmente
#'   disponiveis os Censos de 1991, 2000 e 2010.
#' @param title,subtitle,caption String. Controlam o titulo, sibtitulo e
#'   legenda do maior nivel.
#' @param bar Logical. Se TRUE, a colorbar da renda e plotada.

r_m = function(estado,
               etnia = c("PRETO", "BRANCO", "PARDO", "INDIGENA", "AMARELO"),
               fonte = c("censo"),
               ref = c("1991", "2000", "2010"),
               n_nomes = 5, p_nomes = 0,
               from = 500, to = 2500, by = 500, bar = TRUE,
               title = NULL, subtitle = NULL, caption = NULL) {

  # montar variavel a partir da fonte e referencia
  data = get(paste0(fonte, "_", ref))

  data = data %>%
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
            plot.title.position = "panel",
            axis.title.y = element_text(angle = 90))

    if (estado == "ES") {

      plot + coord_sf(xlim = c(-42, -39.5))

    } else{

      plot

    }
  })


  # draw colorbar?

  colorbar = if(bar == TRUE) {

    guide_colourbar(title = "renda media familiar",
                    title.position = "top",
                    title.hjust = 0.5)
  } else {

    "none"
  }


  # final plot

  reduce(plots, `+`) +
    theme(legend.position = "bottom",
          legend.key.width = unit(1.5, "cm"),
          axis.title.y = element_text(angle = 90)) +
    guides(fill = colorbar) +
    plot_layout(guides = "collect") +
    plot_annotation(
      title = title,
      subtitle = subtitle,
      caption = caption,
      theme = theme(legend.position = "bottom",
                    plot.title = element_text(size = 18))) &
    theme(text = element_text(family = "serif"),
          panel.background = element_rect(fill = "aliceblue"))

}
