## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Optical Profilometry
#  opticalProfilometry_data <- data.frame(
#    'sampleID' = c('sa12345', 'sa24682'),
#    'rrms' = c('0.241', '1.546'),
#    'magnification' = c('10x', '2.5x'),
#    'formRemoved' = c('Plane', '4th Order Polynomial'),
#    'surface' = c('Polyamide', 'Copper'),
#    'stitch' = c('Yes', 'No'),
#    'stitchNCols' = c(3, NA),
#    'stitchNRows' = c(4, NA),
#    'exposureCondition' = c('A', 'B'),
#    'hoursExposed' = c(100, 1000)
#  )
#  
#  # This will generate json-ld files for the example data.
#  opticalProfilometry_output <- fairify_data(opticalProfilometry_data, domain = 'opticalProfilometry', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Optical Profilometry schema diagram"----
knitr::include_graphics("opticalProfilometry_schema.png")

