## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for FE formulations
#  fe_exp <- data.frame(
#    'material' = c('FK-800', 'Kel-F'),
#    'batch' = c('AA', 'G-mixed'),
#    'substrate' = c('Si', 'Glass'),
#    'afmChannel' = c('Height', 'Phase'),
#    'solventType' = c('Ethanol', 'Ethyl acetate')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(fe_exp, domain = '')

## ---- out.width="1200px", echo=FALSE, fig.cap="FE Formulations schema diagram"----
knitr::include_graphics("fe-formulations.png")

