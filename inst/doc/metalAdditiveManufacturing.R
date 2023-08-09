## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Metal AM
#  metalAM_data <- data.frame(
#    'sampleID' = c('sa12345', 'sa24682'),
#    'printMethod' = c('multi', 'single'),
#    'manufacturer' = c('A', 'B'),
#    'material' = c('316L', '718Inconel'),
#    'laserSpeed' = c(50, 10)
#  )
#  
#  # This will generate json-ld files for the example data
#  metal_output <- fairify_data(metalAM_data, domain = '')

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  
#  from fairmaterials.fairify_data import *
#  import pandas as pd
#  
#  # create python data frame for Metal AM
#  
#  data = {
#    'sampleID':['sa12345', 'sa24682'],
#    'printMethod' = ['multi', 'single'],
#    'manufacturer' = ['A', 'B'],
#    'material' = ['316L', '718Inconel'],
#    'laserSpeed' = [50, 10]
#  
#  }
#  
#  am_data = pd.DataFrame(data)
#  
#  # This will generate JSON-LD file for the example data in Python
#  fairify_data(am_data,'am_metal')
#  

## ---- out.width="1200px", echo=FALSE, fig.cap="Metal AM schema diagram"-------
knitr::include_graphics("metalAdditiveManufacturing.png")

