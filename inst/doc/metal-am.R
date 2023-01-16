## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for polymer AM
#  metalAM_data <- data.frame(
#    'sampleID' = c('sa12345', 'sa24682'),
#    'printMethod' = c('multi', 'single'),
#    'manufacturer' = c('A', 'B'),
#    'material' = c('316L', '718Inconel'),
#    'laserSpeed' = c(50, 10)
#  )
#  
#  # This will generate json-ld files for the example data
#  metal_output <- fairify_data(metalAM_data, domain = '')

## ---- out.width="1200px", echo=FALSE, fig.cap="Metal AM schema diagram"-------
knitr::include_graphics("metal-am.png")

