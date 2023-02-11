## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for polymer AM
#  polymerAM_data <- data.frame(
#    'sampleID' = c('sa12345', 'sa24682'),
#    'printMethod' = c('FDM', 'FDM'),
#    'manufacturer' = c('A', 'B'),
#    'material' = c('ABS', 'PLA'),
#    'surfaceRoughness' = c(10, 5),
#    'flowRate' = c(8, 12)
#  )
#  
#  # This will generate json-ld files for the example data.
#  polymer_output <- fairify_data(polymerAM_data, domain = 'PolymerAM', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Polymer AM schema diagram"-----
knitr::include_graphics("polymerAdditiveManufacturing.png")

