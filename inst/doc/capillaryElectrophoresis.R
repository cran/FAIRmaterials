## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for CE
#  CE_exp <- data.frame(
#    'bufferpH' = c('7.4', '6.8'),
#    'appliedVoltage' = c('26', '30'),
#    'columnTemperature' = c('50C', '60C'),
#    'capillaryLength' = c('15cm', '30cm'),
#    'capillaryMaterial' = c('silica', 'polyacrylamide')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(CE_exp, domain = 'CapillaryElectrophoresis', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="CE Formulations schema diagram"----
knitr::include_graphics("capillaryElectrophoresis.png")

