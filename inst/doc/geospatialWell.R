## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for well log header information
#  welllog_data <- data.frame(
#    'wellID' = c('34019202560000', '34019202860000'),
#    'well' = c('RP SMITH& ST EVANS', 'CLARK ET AL UNIT'),
#    'field' = c('EAST CANTON', 'WILDCAT'),
#    'date' = c('10-9-1966', '6-30-1967'),
#    'operator' = c(SCHLUMBERGER, SCHLUMBERGER),
#    'startIndex' = c(0.0, 1187)
#     'endIndex' = c(5100.0, 5170),
#    'step' = c(0.5, 0.5)
#  )
#  
#  
#  # This will generate json-ld files for the example data
#  well_log_output <- fairify_data(welllog_data, domain = 'welllog')

## ---- out.width="1200px", echo=FALSE, fig.cap="Well Log schema diagram"-------
knitr::include_graphics("well_log.png")

