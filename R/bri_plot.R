#' Plotar mapa de desigualdade racial
#'
#' Plota o mapa da desigualdade racial nos municipios brasileiros.
#' Cada mapa e um objeto ggplot2 combinado pelo `patchwork`.
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
#' @param tipo String. Variavel socioeconomia a ser utilizada para a plotagem.
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
#'
#' @details A definicao de pobreza e pobreza extrema para o IBGE sao,
#'   respectivamente, pessoas de renda inferior a 1/2 salario minimo e pessoas
#'   de renda inferior a 1/4 salario minimo.

bri_plot = function(estado,
                    etnia = c("PRETO", "BRANCO", "PARDO",
                              "INDIGENA", "AMARELO"),
                    tipo = c("renda", "pobreza", "pobrezax"),
                    fonte = c("censo"),
                    ref = c("2010", "2000", "1991"),
                    n_nomes = 2, p_nomes = 1000,
                    from = 0, to = 3000, by = 500, bar = TRUE,
                    title = NULL, subtitle = NULL, caption = NULL) {

  # evaluate args
  etnia = match.arg(etnia, c("PRETO", "BRANCO", "PARDO",
                             "INDIGENA", "AMARELO"), several.ok = TRUE)
  tipo = match.arg(tipo)
  fonte = match.arg(fonte)
  ref = match.arg(ref)

  to = if (missing(to)) {
    ifelse(tipo == "renda", to, 1)
  } else {
    to
  }

  by = if (missing(by)) {
    ifelse(tipo == "renda", by, 0.2)
  } else {
    by
  }



  # montar data var a partir da fonte e referencia
  data = get(paste0(fonte, "_", ref))

  # montar dataset
  data = data %>%
    filter(abbrev_state == estado)

  # montar graficos
  plots = lapply(etnia, function(etn) {

    # montar variável fill
    fill = case_when(tipo == "renda" ~ paste0("RM_", etn),
                     tipo == "pobreza" ~ paste0("POB_", etn),
                     tipo == "pobrezax" ~ paste0("POBX_", etn))

    # montar variavel de populacao
    pops = case_when(tipo == "renda" ~ paste0("DENRENDA_", etn),
                     tipo == "pobreza" ~ paste0("NUMPOBRES_", etn),
                     tipo == "pobrezax" ~ paste0("NUMPOBRESX_", etn))


        # graficos
    plot = data %>%
      ggplot(
        aes(geometry = geom,
            fill = get(fill),
            label = if (tipo == "renda") {
              paste(name_muni, scales::dollar(get(fill)), sep = "\n")
            } else {
              paste(name_muni, scales::percent(get(fill)), sep = "\n")
            })) +
      geom_sf() +
      ggrepel::geom_label_repel(
        data = data %>%
          arrange(get(fill)) %>%
          filter(!is.na(get(fill))) %>%
          filter(get(pops) >= p_nomes) %>%
          filter(row_number() %in% 1:n_nomes |
                   row_number() %in%
                   (length(get(fill)) - n_nomes + 1):(length(get(fill)))),
        color = "white", stat = "sf_coordinates") +
      scale_fill_continuous(breaks = seq(from = from + by,
                                         to = to - by,
                                         by = by),
                            limits = c(from, to), type = "viridis") +
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
  colorbar = if (bar == TRUE) {

    guide_colourbar(title = paste(tipo),
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
