## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # Create R data frame for xrd
#  bldg_data <- data.frame(
#    "PremisesName" = c("bldg 680", "bldg 686", "bldg 352"),
#    "OperatorType" = "Food Sales",
#    "Longitude" = c(-75.27, -76.88, -78.52),
#    "Latitude" = c(40.68, 41.17, 40.00),
#    "City" = c("Easton",       "Montgomery",   "Bedford"),
#    "County" = c("Northampton", "Lycoming",    "Bedford"),
#    "State" = "PA",
#    "PostalCode" = c(18045, 17752, 15522),
#    "ASHRAE" = "5A",
#    "KoppenClimate" = c("Dfa", "Dfa", "Cfa"),
#    "FloorAreaPercentage" = 0.88,
#    "FloorAreaValue" = c(6077, 4913, 5333),
#    "OverallWindowToWallRatio" = 0.22,
#    "ConditionedFloorsAboveGrade" = 1
#  )
#  
#  # This will generate JSON-LD file for the example data in R
#  output <- fairify_data(bldg_data, domain = 'building')

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  from fairmaterials.fairify_data import *
#  import pandas as pd
#  
#  # create python data frame for xrd
#  data = {'PremisesName':['bldg 680', 'bldg 686', 'bldg 352'],
#          'OperatorType':['Food Sales', 'Food Sales', 'Food Sales'],
#          'Longitude':[-75.27, -76.88, -78.52],
#          'Latitude':[40.68, 41.17, 40.00],
#          'City':['Easton',       'Montgomery',   'Bedford'],
#          'County':['Northampton', 'Lycoming',    'Bedford'],
#          'State':['PA', 'PA', 'PA'],
#          'PostalCode':[18045, 17752, 15522],
#          'ASHRAE':['5A', '5A', '5A'],
#          'KoppenClimate':['Dfa', 'Dfa', 'Cfa'],
#          'FloorAreaPercentage':[0.88, 0.88, 0.88],
#          'FloorAreaValue':[6077, 4913, 5333],
#          'OverallWindowToWallRatio':[0.22, 0.22, 0.22],
#          'ConditionedFloorsAboveGrade':[1, 1, 1]
#         }
#  
#  
#  bldg_data = pd.DataFrame(data)
#  
#  # This will generate JSON-LD file for the example data in Python
#  fairify_data(bldg_data,'building')
#  

## ---- out.width="1600px", echo=FALSE------------------------------------------
knitr::include_graphics("building_schema.png")

