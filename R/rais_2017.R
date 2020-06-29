#' Annual Social Information Report (Rais) 2017
#'
#' A list of dataframes containing the Rais for the year 2017 of each Brazilian
#' state. The dataframes were summarized so they are in the same structure as
#' of Census. Note that Rais's race information is filled in by the employer,
#' often by outsourced third party, and not by the worker itself. Thus, there is
#' a substancial amount of undeclared racial status.
#'
#' @format A list with 27 elements (states), each with 22 rows and 43 variables:
#' \describe{
#'   \item{abbrev_state}{siglas dos estados}
#'   \item{name_muni}{nome do municipio}
#'   \item{geom}{limites geograficos dos municípios}
#' }
#' @source \url{ftp://ftp.mtps.gov.br/pdet/microdados/}
"rais_2017"
