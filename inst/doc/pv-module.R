## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for PV Modules
#  module_example <- data.frame('CellTechnologyType' = c('PERC', 'Al-BSF'),
#                              'CellMaterial' = c('mono-crystalline', 'poly-crystalline'),
#                              'EncapsulantMaterial' = c('EVA', 'POE'),
#                              'BacksheetMaterial' = c('PVF', 'PET'),
#                              'BacksheetColor' = c('White', 'Black'),
#                              'ProdMfr' = c('CSI', 'FirstSolar'),
#                              'ProdCode' = c('BiHiKu7', 'BiHiKu7255'),
#                              'CellCount' = c(60, 72),
#                              'ModuleEfficiency' = c(20.1, 22),
#                              'GlassThickness' = c(2, 1.5),  # GT and J_Box are not included in the
#                              'J_Box' = c('IP68', 'IP70')) # base template, but they still have a spot!
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(module_example, domain = 'PVModule', saveLocal = TRUE)

## ---- out.width="800px", echo=FALSE, fig.cap="PV Module schema diagram"-------
knitr::include_graphics("pv-module.png")

