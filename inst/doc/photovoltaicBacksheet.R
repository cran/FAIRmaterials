## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for PV Polymer Backsheets
#  pvbacksheet_example <- data.frame('SiteName' = c('SS-16-7', 'SS-16-7'),
#                              'RowName' = c('B01R01', 'B01R02'),
#                              'BacksheetMaterial' = c('PVDF', 'PVDF'),
#                              'YI' = c('1.1271', '1.0247'),
#                              'Gloss60' = c('29.1491', '28.7791'))
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(pvbacksheet_example, domain = 'PolymerBacksheets', saveLocal = TRUE)

## ---- out.width="3200px", echo=FALSE, fig.cap="PV Polymer Backsheet diagram"----
knitr::include_graphics("pv-backsheet.png")

