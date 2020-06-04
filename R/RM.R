#' Plotar gráfico de renda média branca x preta
#'
#' Essa função plota os gráficos de renda média per capita branca e preta.
#' @export

RM = function(estado, from = 500, to = 2500, by = 500, n.nomes = 5) {

  rm_p = RM_P(estado, from, to, by, n.nomes)
  rm_b = RM_B(estado, from, to, by, n.nomes)

  rm_p + rm_b +
    plot_layout(guides = "collect") +
    plot_annotation(title = "DESIGUALDADE DE RENDA",
                    subtitle = "PRETA/PARDA VERSUS BRANCA",
                    caption = "dados: IBGE/censo 2010 | elaboração: @albersonmiranda",
                    theme = theme(legend.position = "bottom",
                                  plot.title = element_text(size = 18))) &
    theme(text = element_text(family = "serif"),
          panel.background = element_rect(fill = "aliceblue"))
}
