## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for CE
#  ASTER_Gdem <- data.frame(
#    'latitude' = c('41.4993567', '43.4724567'),
#    'longitude' = c('81.6944678', '86.8930345'),
#    'typeBody' = c('land', 'lake'),
#    'elevation' = c('250m', '300cm'),
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(ASTER_Gdem, saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="CE Formulations schema diagram"----
knitr::include_graphics("asterGdem.png")

