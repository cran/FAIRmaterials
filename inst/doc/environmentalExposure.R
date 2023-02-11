## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Environmental Exposure
#  environmental_exposure <- data.frame(
#    'temperature' = c('80', '60'),
#    'RelativeHumidity' = c('85', '85')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(environmental_exposure, domain = 'EnvironmentalExposure', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Environmental Exposure schema diagram"----
knitr::include_graphics("environmentalExposure.png")

