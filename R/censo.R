#' Census
#'
#' A list of dataframes containing Census data from each Brazilian state.
#'
#' @format A list with 3 elements (1991, 2000 and 2010), each around 5 thousand
#' rows and 61 variables:
#' \describe{
#'   \item{abbrev_state}{siglas dos estados}
#'   \item{name_muni}{nome do municipio}
#'   \item{geom}{limites geograficos dos municípios}
#' }
#' @source \url{ftp://ftp.mtps.gov.br/pdet/microdados/}
"censo"
