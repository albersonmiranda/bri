library(bri)

# objetos a serem testados
es = bri_plot("ES", fonte = "censo", ref = "2010")
rj = bri_plot("RJ")

# resultado esperado
result = c("patchwork", "gg", "ggplot")

test_that("bri_plot works", {
  expect_equal(class(es), result)
  expect_equal(class(rj), result)
})
