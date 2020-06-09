library(desigualdade)

# objetos a serem testados
ES = r_m("ES")
RJ = r_m("RJ")

# resultado esperado
result = c("patchwork", "gg", "ggplot")

test_that("r_m funciona", {
  expect_equal(class(ES), result)
  expect_equal(class(RJ), result)
})
