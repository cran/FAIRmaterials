## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for stream water header information
#  stream_water <- data.frame(
#    'siteNumber' = c("01491000","01645000"),
#    'date' = c('8-19-1998', '01-30-2002'),
#    'parameterCode' = c('sediment', 'information')
#  )
#  
#  
#  # This will generate json-ld files for the example data
#  stream_water_output <- fairify_data(stream_water, domain = 'streamWater')

## ---- out.width="1200px", echo=FALSE, fig.cap="Well Log  schema diagram"------
knitr::include_graphics("streamWater.png")

