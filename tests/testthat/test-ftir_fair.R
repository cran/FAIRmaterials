test_that("The code outputs a correct json", {
  x <- 'ftir_measurement1'

  y <- ftir_fair(x)

  # We expect there to be no more << or >> characters in the strings, as we would have filled those values with our function

  expect_identical(stringr::str_count(y, '<<'), as.integer(0))
  expect_identical(stringr::str_count(y, '>>'), as.integer(0))
})
