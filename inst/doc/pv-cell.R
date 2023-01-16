## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for PV Cells
#  cell_example <- data.frame('CellCutType' = 'Full',
#                             'CellTechnologyType' = 'MonoSi')
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(cell_example, domain = 'PVCell', saveLocal = TRUE)

## ---- out.width="800px", echo=FALSE, fig.cap="PV Cell schema diagram"---------
knitr::include_graphics("PVCells.drawio.png")

