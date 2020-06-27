# DESIGUALDADE 0.0.0.9003

* função `r_m()` generalizada para `des_plot()`
* argumentos adicionados:
- `tipo`: renda média, % pobres, % extrema pobreza

# DESIGUALDADE 0.0.0.9002

* adicionados os Censos de 1991 e 2000
* argumentos de `r_m()`:
- `autor` alterado para `caption`
- `bar`: define se será plotada a colorbar
- `ref`: escolha do ano do Censo
- `fonte`: escolha da fonte (atualmente apenas censo)

# DESIGUALDADE 0.0.0.9001

* Função renda média por família renomeada para `r_m()`
* `r_m()` agora possui vários parâmetros:
  - Etnia: pretos, brancos, pardos, indígenas e amarelos
  - Autor, título e subtítulo
  - n_nomes: indicar a quantidade de nomes de municípios a ser exibida
  - p_nomes: filtrar a exibição de nomes de municípios de acordo com o tamanho da população daquela etnia
* Github Actions para CMDCheck e Lintr
* Adicionado teste para verificar se o resultado da função `r_m()` é um objeto ggplot2

# DESIGUALDADE 0.0.0.9000

* Versão inicial.
* `RM()` - plota a renda mensal per capita por município em dois gráficos: brancos e pretos/pardos a partir do Censo de 2010.
