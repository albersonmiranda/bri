#' Dados de Censo do IBGE
#'
#' Um dataset contendo dados do último censo do IBGE com informações de raça.
#' Adicionalmente, foi calculada a renda média e incluída as informações
#' geográficas dos municípios a partir do pacote geobr.
#'
#' @format A tibble with 5565 rows and 34 variables:
#' \describe{
#'   \item{abbrev_state}{siglas dos estados}
#'   \item{name_muni}{nome do município}
#'   \item{geom}{limites geográficos dos municípios}
#'   \item{renda_media_NEGRA}{renda média ponderada entre as rendas médias per capita de pretos e pardos}
#' }
#' @source \url{http://tabnet.datasus.gov.br/cgi/ibge/censo/rendadescr.htm}
"censo_des"
