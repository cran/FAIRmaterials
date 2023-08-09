## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for PV Systems
#  system_example <- data.frame('Latitude' = c(30.1702, 28.32048),
#                               'ProdMfr' = c('CSI', 'FirstSolar'),
#                               'SystemID' = c('s1435', 's1284'))
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(system_example, domain = 'PVSystem', saveLocal = TRUE)

## ---- out.width="800px", echo=FALSE, fig.cap="PV Systems schema diagram"------
knitr::include_graphics("pv-system.png")

