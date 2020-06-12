
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DESIGUALDADE RACIAL NO BRASIL

<!-- badges: start -->

![R-CMD-check](https://github.com/albersonmiranda/desigualdade/workflows/R-CMD-check/badge.svg?branch=master&event=push)
![lint](https://github.com/albersonmiranda/desigualdade/workflows/lint/badge.svg?branch=master&event=push)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

O objetivo desse pacote é facilitar a plotagem de gráficos que
evidenciam a desigualdade racial nos municípios brasileiros.

## Instalação

Você pode instalar a versão de desenvolvimento do pacote pelo
[GitHub](https://github.com/) com:

``` r
# install.packages("devtools")
devtools::install_github("albersonmiranda/desigualdade")
```

## Exemplos

Esse é um exemplo básico em que mostra como plotar o gráfico da
desigualdade de renda entre pretos e amarelos nos municípios de São
Paulo, exibindo os 3 municípios de maior renda e os 3 de menor:

``` r
library(desigualdade)

des_plot("SP", etnia = c("PRETO", "AMARELO"), n_nomes = 3,
    caption = "dados: censo/2010 | elaboração: @albersonmiranda",
    title = "DESIGUALDADE RACIAL",
    subtitle = "RENDA PRETA VERSUS AMARELA EM SP")
```

![](man/figures/README-example-1.png)<!-- -->

Também pode-se utilizar o `patchwork` para controlar o layout do plot
final:

``` r
library(patchwork)

des_plot("RO", etnia = c("PRETO", "PARDO", "BRANCO", "INDIGENA"),
    tipo = "pobreza", n_nomes = 1,
    caption = "dados: censo/2010 | elaboração: @albersonmiranda",
    title = "DESIGUALDADE RACIAL",
    subtitle = "% DE POBRES EM RONDÔNIA") +
  plot_layout(ncol = 2)
```

![](man/figures/README-example2-1.png)<!-- -->

É possível ir além e combinar vários `des_plot()` com diferentes
argumentos:

``` r

library(ggplot2)

design = "
AABBCC
AABBDD
"
des_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "2010",
    caption = "dados: censo/IBGE | elaboração: @albersonmiranda",
    title =  "DESIGUALDADE RACIAL NO ESPIRITO SANTO",
    subtitle = "EVOLUÇÃO DAS RENDAS PRETA E BRANCA") *
  ggtitle("2010") +
  
  des_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "1991", n_nomes = 1,
      bar = FALSE) * ggtitle("1991") +
  
  des_plot("ES", etnia = c("PRETO", "BRANCO"), ref = "2000", n_nomes = 1,
      bar = FALSE) * ggtitle("2000") +
  
  plot_layout(design = design)
```

![](man/figures/README-example3-1.png)<!-- -->
