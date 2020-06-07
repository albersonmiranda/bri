library(desigualdade)

# objetos a serem testados
ES = RM("ES")
RJ = RM("RJ")

# resultado esperado
result = c("patchwork", "gg", "ggplot")

test_that("RM funciona", {
  expect_equal(class(ES), result)
  expect_equal(class(RJ), result)
})
