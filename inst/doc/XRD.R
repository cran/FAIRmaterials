## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # Create R data frame for xrd
#  xrd_data <- data.frame(
#    'said' = c('Ce02-lpa', 'CeO2-Atex'),
#    'indx"' = c(52, 53),
#    'img_stck' = c(12, 15),
#    'beamnrgy' = c(69.525, 69.525),
#    'wavelngt' = c(0.1783, 0.1783)
#  )
#  
#  # This will generate JSON-LD file for the example data in R
#  output <- fairify_data(xrd_data, domain = 'XRD')

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  from fairmaterials.fairify_data import *
#  import pandas as pd
#  
#  # create python data frame for xrd
#  data = {'said':['Ce02-lpa','Ce02-Atex'],
#          'indx':[52,53],
#          'img_stck':[12,15],
#          'beamnrgy':[69.525, 69.525],
#          'wavelngt':[0.1783, 0.1783]
#         }
#  
#  
#  xrd_data = pd.DataFrame(data)
#  
#  # This will generate JSON-LD file for the example data in Python
#  fairify_data(xrd_data,'XRD')
#  

## ---- out.width="1600px", echo=FALSE------------------------------------------
knitr::include_graphics("XRD.drawio.png")

