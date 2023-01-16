## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for PV Inverters
#  inverter_example <- data.frame('InverterStyle' = 'Central',
#                                 'ProdMfr' = 'CSI')
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(inverter_example, domain = 'PVInverter', saveLocal = TRUE)

## ---- out.width="800px", echo=FALSE, fig.cap="PV Inverter schema diagram"-----
knitr::include_graphics("PVInverter.drawio.png")

