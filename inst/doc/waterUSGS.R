## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for water USGS data and metadata
#  stationMetadaUsgs <- data.frame(
#    'lat' = c('41.19893889', '30.02716385'),
#    'lot' = c('-84.7444033', '-952579888'),
#    'state' = c('Ohio', 'Texas'),
#    'county' = c('Pauding', 'Harris'),
#  )
#  
#  
#  # This will generate JSON-LD files for the example data
#  outputMetada <- fairify_data(stationMetadataUsgs, saveLocal = TRUE)
#  

## ---- out.width="1200px", echo=FALSE, fig.cap="Schema diagram for Water USGS"----
knitr::include_graphics("waterUSGS.png")

