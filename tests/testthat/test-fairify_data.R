test_that("The output is right for a given input", {

  # Create test dataframe
  test_df <- data.frame('CellMaterial' = 'mono-silicon',
                        'EncapsulantMaterial' = 'EVA')

  output <- jsonlite::fromJSON(fairify_data(test_df, domain = 'photovoltaicModule')[[1]])

  expect_identical(output$ProdModule$ProdCell$CellMaterial$value, 'mono-silicon')
  expect_identical(output$ProdModule$ProdEncapsulant$EncapsulantMaterial$value, 'EVA')

})
