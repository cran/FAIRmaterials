## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for XCT
#  xct_data <- data.frame(
#    'SampleID' = c('sx_0001_0000', 'sx_0032_1245'),
#    'Alloy' = c('AlMg', 'AlMg'),
#    'SequenceNumber' = c('0001', '0032'),
#    'StackNumber' = c('0000', '1245'),
#    'FilePath' = c('/home/0001_0000.tiff', '/home/0032_1245.tiff'),
#    'Load' = c(10, 16)
#  )
#  
#  # This will generate json-ld files for the example data
#  # Be sure to put in exact domain name as shown in fairify_data documentation.
#  # See ?fairify_data for domain names.
#  xct_output <- fairify_data(xct_data, domain = 'XCT')

## ---- out.width="1200px", echo=FALSE, fig.cap="XCT schema diagram"------------
knitr::include_graphics("computedTomographyXRay.png")

