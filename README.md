
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BRAZILIAN RACIAL INEQUALITY: THE {BRI} PACKAGE

<!-- badges: start -->

![R-CMD-check](https://github.com/albersonmiranda/desigualdade/workflows/R-CMD-check/badge.svg?branch=master&event=push)
![lint](https://github.com/albersonmiranda/desigualdade/workflows/lint/badge.svg?branch=master&event=push)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

{bri} \[/brē/\] is a tidy and sf-ready data package focused in
facilitate plotting racial inequality in Brazilian municipalities.

## Installation

You can install the development version of the package at
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("albersonmiranda/bri")
```

## Examples

This is a basic example that shows how to plot income inequality between
blacks and yellows in the municipalities of São Paulo, showing top 3
municipalities of highest income and bottom 3 of the lowest, labelling
only the ones with sample size greater than 1000 workers of each
selected ethnicity:

``` r
library(bri)

bri_plot("SP", etnia = c("PRETO", "AMARELO"), fonte = "rais", ref = "2017",
         n_nomes = 3, p_nomes = 1000, to = 7000, by = 1400,
         caption = "source: Rais/2017 | elaboração: @albersonmiranda",
         title = "RACIAL INEQUALITY",
         subtitle = "BLACK VERSUS YELLOW WAGES")
```

![](man/figures/README-example-1.png)<!-- -->

{Patchwork} can also be used to control the layout of the final plot:

``` r
library(patchwork)

bri_plot("RO", etnia = c("PRETO", "PARDO", "BRANCO", "INDIGENA"),
    tipo = "pobreza", n_nomes = 1,
    caption = "dados: censo/2010 | elaboração: @albersonmiranda",
    title = "DESIGUALDADE RACIAL",
    subtitle = "% DE POBRES EM RONDÔNIA") +
  plot_layout(ncol = 2)
```

![](man/figures/README-example2-1.png)<!-- -->

It is possible to go further and combine several `bri_plot ()` with
different arguments:

``` r

library(ggplot2)

design = "
AABBCC
AABBDD
"
bri_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "2010",
    caption = "dados: censo/IBGE | elaboração: @albersonmiranda",
    title =  "DESIGUALDADE RACIAL NO ESPIRITO SANTO",
    subtitle = "EVOLUÇÃO DAS RENDAS PRETA E BRANCA") *
  ggtitle("2010") +
  
  bri_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "1991", n_nomes = 1,
      bar = FALSE) * ggtitle("1991") +
  
  bri_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "2000", n_nomes = 1,
      bar = FALSE) * ggtitle("2000") +
  
  plot_layout(design = design)
```

![](man/figures/README-example3-1.png)<!-- -->
