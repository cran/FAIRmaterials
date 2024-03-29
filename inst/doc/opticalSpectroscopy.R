## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  library(FAIRmaterials)
#  
#  # An example data frame for Optical Spectroscopy
#  # FTIR spectroscopy example from PMMA samples
#  
#  FTIR_example <- data.frame(
#    'wavelength' = c('649.57', '2650.5'),
#    'spc' = c('0.019966', '0.00315458'),
#    'SampleMaterial' = c('UVT', 'FF1'),
#    'SamplePhase' = c('solid', 'solid'),
#    'sampleID' = c('sa17435', 'sa17559')
#  )
#  
#  # This will generate JSON-LD file for the example data
#  output <- fairify_data(FTIR_example, domain = 'OpticalSpectroscopy', saveLocal = TRUE)

## ---- out.width="1200px", echo=FALSE, fig.cap="Optical Spectroscopy schema diagram"----
knitr::include_graphics("opticalSpectroscopy.png")

