#' Dados de Censo do IBGE
#'
#' Um dataset contendo dados do último censo do IBGE com informações de raça.
#' Adicionalmente, foi calculada a renda média e desemprego, e incluída as informações
#' geográficas dos municípios a partir do pacote geobr.
#'
#' @format A tibble with 5565 rows and 34 variables:
#' \describe{
#'   \item{abbrev_state}{siglas dos estados}
#'   \item{name_muni}{nome do município}
#'   \item{geom}{limites geográficos dos municípios}
#' }
#' @source \url{http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm}
"data_2010"
