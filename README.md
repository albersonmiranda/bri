
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

## Exemplo

Esse é um exemplo básico em que mostra como plotar o gráfico da
desigualdade de renda entre brancos, pretos e amarelos nos municípios do
Rio de Janeiro, exibindo os 3 municípios de maior renda e os 3 de menor:

``` r
library(desigualdade)

r_m("RJ", etnia = c("PRETO", "BRANCO", "AMARELO"), n_nomes = 3, p_nomes = 1000,
    autor = "@albersonmiranda",
    titulo = "DESIGUALDADE RACIAL",
    subtitulo = "RENDA PRETA VERSUS BRANCA E AMARELA")
```

![](man/figures/README-example-1.png)<!-- -->

Também é possível utilizar o `patchwork` para controlar o layout do plot
final:

``` r
library(patchwork)

r_m("ES", etnia = c("PRETO", "BRANCO", "INDIGENA"),
    n_nomes = 3, p_nomes = 1000,
    autor = "@albersonmiranda",
    titulo = "DESIGUALDADE RACIAL",
    subtitulo = "ESPÍRITO SANTO") +
  plot_layout(ncol = 3, widths = c(2,1,1))
```

![](man/figures/README-example2-1.png)<!-- -->
