## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Soil WoSis
#  soilWosis <- data.frame(
#    'lat' = c('41.19893889', '30.02716385'),
#    'lot' = c('-84.7444033', '-952579888'),
#    'nitrogen' = c('35.56', '60.89'),
#    'pH' = c('7.3', '6.8'),
#  )
#  
#  # This will generate JSON-LD files for the example data
#  output <- fairify_data(soilWosis, saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Schema for Soil data from WoSis"----
knitr::include_graphics("SoilWoSis.png")

