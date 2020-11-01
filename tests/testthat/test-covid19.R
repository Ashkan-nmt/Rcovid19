library(covid19)
test_that("number of data variables", {
  expect_equal(ncol(update_covid_data()), 5)
})
#> Test passed
