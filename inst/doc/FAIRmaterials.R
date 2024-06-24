## ----out.width="675px", dpi=1000, echo=FALSE----------------------------------
knitr::include_graphics("namespacesheet.png")

## ----out.width="675px", dpi=1000, echo=FALSE----------------------------------
knitr::include_graphics("ontoinfosheet.png")

## ----out.width="675px", dpi=1000, echo=FALSE----------------------------------
knitr::include_graphics("vardefsheet.png")

## ----out.width="675px", dpi=1000, echo=FALSE----------------------------------
knitr::include_graphics("reldefsheet.png")

## ----out.width="675px", dpi=1000, echo=FALSE----------------------------------
knitr::include_graphics("valtypesheet.png")

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("FAIRmaterials")
#  
#  library(FAIRmaterials)

## ----eval=F-------------------------------------------------------------------
#  # Process the CSV files in the PV folder
#  example_folder1 <- system.file("extdata", "PV", package = "FAIRmaterials")
#  FAIRmaterials::process_ontology_files(example_folder1, add_external_onto_info = FALSE)

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="PV Visualization with Value Types"----
knitr::include_graphics("PV_svg_w_valuetype.png")

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="PV Visualization with Value Types"----
knitr::include_graphics("mds-pvModuleGraph.png")

## ----eval=F-------------------------------------------------------------------
#  # Process the CSV files in the XRay folder
#  example_folder2 <- system.file("extdata", "XRay", package = "FAIRmaterials")
#  FAIRmaterials::process_ontology_files(example_folder2, add_external_onto_info = FALSE)

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="XRay Visualization with Value Types"----
knitr::include_graphics("XRay_svg_w_valuetype.png")

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="PV Visualization with Value Types"----
knitr::include_graphics("mds-XraySampleGraph.png")

## ----eval=F, message=FALSE----------------------------------------------------
#  FAIRmaterials::process_ontology_files(example_folder1, include_graph_valuetype = FALSE, add_external_onto_info = FALSE)

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="PV Visualization without Value Types"----
knitr::include_graphics("PV_svg_wo_valuetype2.png")

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="PV Visualization without Value Types"----
knitr::include_graphics("mds-XraySampleGraph-novaluetype.png")

## ----eval=F, message=FALSE----------------------------------------------------
#  FAIRmaterials::process_ontology_files(example_folder1, include_graph_valuetype = TRUE, add_external_onto_info = TRUE)

## ----eval=F, message=FALSE----------------------------------------------------
#  FAIRmaterials::process_ontology_files(example_folder2, include_graph_valuetype = TRUE, add_external_onto_info = TRUE)

## ----eval=F, message=FALSE----------------------------------------------------
#  FAIRmaterials::process_ontology_files(example_folder2, include_graph_valuetype = TRUE, add_external_onto_info = TRUE)

## ----eval=F-------------------------------------------------------------------
#  example_folder3 <- system.file("extdata", package = "FAIRmaterials")
#  FAIRmaterials::process_ontology_files(example_folder3, add_external_onto_info = FALSE, merge_title = "MergedPVandXRay", merge_base_uri = "https://cwrusdle.bitbucket.io/OntologyFilesOwl/Ontology/", merge_version = "1.0")

## ----out.width="675px", dpi=1000, echo=FALSE, fig.cap="Merged Visualization with Value Types"----
knitr::include_graphics("merged.png")

