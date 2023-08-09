## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Environmental Exposure
#  environmentalExposure <- data.frame(
#    'temperature' = c('80', '60'),
#    'relativeHumidity' = c('85', '85')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(environmentalExposure, domain = 'environmentalExposure', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Environmental Exposure schema diagram"----
knitr::include_graphics("environmentalExposure.png")

