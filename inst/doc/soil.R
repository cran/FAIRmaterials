## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for soil header information
#  soil <- data.frame(
#    'ID' = c("176","250"),
#    'texture' = c('Coarse', 'None'),
#    'AwC' = c('0', '50'),
#    'roots' = c('60-80', '20-40'),
#    'addProp' = c('Petric', 'Vertic')
#  )
#  
#  
#  # This will generate json-ld files for the example data
#  soil_output <- fairify_data(soil, domain = 'soil')

## ---- out.width="1200px", echo=FALSE, fig.cap="soil  schema diagram"----------
knitr::include_graphics("soil.png")

