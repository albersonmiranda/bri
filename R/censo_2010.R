#' Dados de Censo de 2010 do IBGE
#'
#' Um dataset contendo dados do ultimo censo do IBGE com informacoes de raca.
#' Adicionalmente, foi calculada a renda media e desemprego, e incluida as
#' informacoes geográficas dos municipios a partir do pacote geobr.
#'
#' @format A tibble with 5565 rows and 51 variables:
#' \describe{
#'   \item{abbrev_state}{siglas dos estados}
#'   \item{name_muni}{nome do municipio}
#'   \item{geom}{limites geograficos dos municípios}
#' }
#' @source \url{http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm}
"censo_2010"
