#' Convert Dataframe to Json from a Template
#'
#' @param row Row of a user input csv that includes metadata
#' @param domain Json-LD template to be filled by function
#' @param i Iteration of the loop tracker
#' @param unit_dataframe User input units
#'
#' @return FAIRified .json-ld text document
json_conversion <- function(row, unit_dataframe, domain, i) {

  ## Read in the template (on release this will be read from sysdata.rda)

  # Read in the template from the sysdata.rda file
  template <- jsonlite::fromJSON(get(domain))
  #template <- jsonlite::read_json(path = '../../../docs/json-ld/pv-module-json-ld-template.json')

  ## List all of the keys existing in the template
  ## Replace . with $ so R can interpret what's going on

  template_keys <- names(unlist(template))
  template_keys <- gsub('[.]', '$', template_keys)

  template_fill <- template_keys[stringr::str_which(template_keys, 'value')]
  unit_fill <- template_keys[stringr::str_which(template_keys, 'unit')]

  # Some items have a list that come out as unitText1, unitText2, etc
  template_fill <- unique(gsub("[[:digit:]]", "", template_fill))
  unit_fill <- unique(gsub("[[:digit:]]", "", unit_fill))

  # Fill json template

  for (x in colnames(row)) {

    if (any(stringr::str_detect(template_fill, x)) == TRUE) {

      key <- template_fill[stringr::str_which(template_fill, x)]
      unit_key <- unit_fill[stringr::str_which(unit_fill, x)]

      if (inherits(row[[x]], 'character')) {

        eval_statement <- paste0('template$', key, ' <-', '"', row[[x]], '"')

        # Need to make sure the user actually filled in the units
        if (length(unit_dataframe[[x]]) > 0) {
          unit_statement <- paste0('template$', unit_key, ' <-', '"', unit_dataframe[[x]], '"')
        } else {
          unit_statement <- 'NA'
        }
      } else {

        eval_statement <- paste0('template$', key, ' <-', row[[x]])

        if (length(unit_dataframe[[x]]) > 0) {
          unit_statement <- paste0('template$', unit_key, ' <-', '"', unit_dataframe[[x]], '"')
        } else {
          unit_statement <- 'NA'
        }
      }

    } else {   # Let the user add a new key in the additional properties section

      if (i ==1) {

        # Prompt the user about the key they want to add ON THE FIRST ITERATION of loop
        svDialogs::dlg_message(paste0(x, " is not recognized as a key in our template.
                                    Please review the existing keys and reformat if you
                                    find a match. If you can't find a match, please
                                    email us at fairmaterials@gmail.com, and we will
                                    add it to our template. For now, your key will
                                    reside in the AdditionalProperty section
                                    of the json-ld document."))
      }

      if (inherits(row[[x]], 'character')) {

        eval_statement <- paste0('template$additionalProperty$', x, ' <-', '"', row[[x]], '"')
      } else {

        eval_statement <- paste0('template$additionalProperty$', x, ' <-', row[[x]])
      }

    }

    eval(str2expression(eval_statement))

    if (length(unit_statement) > 1) {

      for (statement in unit_statement) {
        eval(str2expression(statement))
      }
    } else if (!stringr::str_detect(unit_statement, 'NA')) {
      eval(str2expression(unit_statement))
    }

  }

  return(jsonlite::toJSON(template, auto_unbox = TRUE))
}


#' FAIRify Data
#'
#' @param dataframe User input metadata dataframe
#' @param unit_dataframe User input units (one row dataframe) \cr
#' @param domain Json-LD template to be filled by function \cr
#' @param saveLocal Boolean stating whether the files should be saved locally \cr
#' User can FAIRify data in the following domains: \cr \cr
#' asterGdem \cr
#' buildings \cr
#' capillaryElectrophoresis \cr
#' computedTomographyXRay \cr
#' diffractionXRay \cr
#' environmentalExposure \cr
#' geospatialWell \cr
#' materialsProcessing \cr
#' metalAdditiveManufacturing \cr
#' opticalProfilometry \cr
#' opticalSpectroscopy \cr
#' photovoltaicBacksheet \cr
#' photovoltaicCell \cr
#' photovoltaicInverter \cr
#' photovoltaicModule \cr
#' photovoltaicSystem \cr
#' polymerAdditiveManufacturing \cr
#' polymerFormulation \cr
#' soil \cr
#' streamWater
#'
#' @description Function that receives user input metadata and converts that
#' into a FAIRified json-ld file based on a template created as part of this
#' package.
#' @return FAIRified .json-ld text document
#' @export
#'
#' @examples
#'
#' metadata <- data.frame('CellMaterial' = 'mono-silicon',
#'                        'Module Efficiency' = 20.1)
#'
#'metadata_units <- data.frame('CellMaterial' = NA,
#'                             'ModuleEfficiency' = '%')
#'
#' fairify_data(metadata, metadata_units, 'photovoltaicModule', saveLocal = FALSE)
fairify_data <- function(dataframe, unit_dataframe = data.frame(), domain, saveLocal = FALSE) {

  output <- list()

  # If the users input a csv file
  if (typeof(dataframe) == 'character') {
    dataframe <- utils::read.csv(dataframe)
  }

  if (typeof(unit_dataframe) == 'character') {
    unit_dataframe <- utils::read.csv(unit_dataframe)
  }

  for(i in 1:nrow(dataframe)) {
    row <- dataframe[i,]

    json <- json_conversion(row, unit_dataframe, domain, i)

    output <- append(output, list(json))
  }

  if (saveLocal) {

    if (!file.exists('JsonFiles')) {

      dir.create('JsonFiles')
    }

    i = 1
    for (text_file in output) {

      write(text_file, paste0('JsonFiles/file', i, '.json'))

      i = i + 1
    }

  }

  return(output)
}

# Document the data

#' This is data to be included in the package
#'
#' @name asterGdem
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name buildings
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name capillaryElectrophoresis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name computedTomographyXRay
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name diffractionXRay
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name environmentalExposure
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name geospatialWell
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name materialsProcessing
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name metalAdditiveManufacturing
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name opticalProfilometry
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name opticalSpectroscopy
#' @docType data
#' @keywords internal
NULL
#' This is data to be included in the package
#'
#' @name photovoltaicBacksheet
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name photovoltaicCell
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name photovoltaicInverter
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name photovoltaicModule
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name photovoltaicSystem
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name polymerAdditiveManufacturing
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name polymerFormulation
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name soil
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name streamWater
#' @docType data
#' @keywords internal
NULL

