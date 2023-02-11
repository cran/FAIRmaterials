## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # Create R data frame for xrd
#  materialsprocessing <- data.frame(
#    'sinteringTemperature' = c(73.96982466, 88.4325155),
#    'sinteringPressure' = c(86.04484907,90.87423125),
#    'sinteringAtmosphere' = c(28.61041584,91.68762828),
#    'thermalCuringTemperature'= c(55.65865317,84.19817531),
#    'thermalCuringPressure' = c(31.68762174,6.547410211),
#    'thermalCuringDuration' = c(93.95743642,41.26231069),
#    'etchingTemperature' = c(91.9706205,16.14196046),
#    'etchingDwellTime' = c(45.58118615,8.525806568),
#    'etchingRampRates'= c(73.99122612,83.11668233)
#  )
#  
#  # This will generate JSON-LD file for the example data in R
#  output <- fairify_data(materialsprocessing, domain = 'MaterialsProcessing')

## ---- message=FALSE, eval=FALSE, python.reticulate = FALSE--------------------
#  from fairmaterials.fairify_data import *
#  import pandas as pd
#  
#  # create python data frame for xrd
#  data = {'sinteringTemperature' : [73.96982466, 88.4325155],
#  'sinteringPressure' : [86.04484907, 90.87423125],
#  'sinteringAtmosphere' : [28.61041584, 91.68762828],
#  'thermalCuringTemperature' : [55.65865317, 84.19817531],
#  'thermalCuringPressure' : [31.68762174, 6.547410211],
#  'thermalCuringDuration' : [93.95743642, 41.26231069],
#  'etchingTemperature' : [91.9706205, 16.14196046],
#  'etchingDwellTime' : [45.58118615, 8.525806568],
#  'etchingRampRates': [73.99122612, 83.11668233]
#         }
#  
#  
#  materialsprocessing = pd.DataFrame(data)
#  
#  # This will generate JSON-LD file for the example data in Python
#  fairify_data(materialsprocessing,'MaterialsProcessing')
#  

## ---- out.width="800px", echo=FALSE-------------------------------------------
knitr::include_graphics("materialsProcessing.drawio.png")

