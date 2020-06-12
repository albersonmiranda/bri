library(desigualdade)

# objetos a serem testados
es = des_plot("ES")
rj = des_plot("RJ")

# resultado esperado
result = c("patchwork", "gg", "ggplot")

test_that("r_m funciona", {
  expect_equal(class(es), result)
  expect_equal(class(rj), result)
})
