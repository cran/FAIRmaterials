## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Cary UV Vis Spectrophotometer
#  caryUvVis <- data.frame(
#    'wavelength' = c('1800', '1691'),
#    'absorbance' = c('0.26916054', '0.63266635')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(caryUvVis, domain = 'caryUvVis', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Cary UV Vis Spectrophotometer schema diagram"----
knitr::include_graphics("caryUvVis.png")

