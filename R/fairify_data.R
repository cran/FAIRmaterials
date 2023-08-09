#' Convert Dataframe to Json from a Template
#'
#' @param row Row of a user input csv that includes metadata
#' @param domain Json-LD template to be filled by function
#' @param i Iteration of the loop tracker
#' @param unit_dataframe User input units
#' @param data_list List of columns included in any of your raw dataframes \cr
#'
#' @return FAIRified .json-ld text document
json_conversion <- function(row, unit_dataframe, domain, i, data_list) {

  ## Read in the template (on release this will be read from sysdata.rda)

  # Read in the template from the sysdata.rda file
  template <- jsonlite::fromJSON(get(domain))
  #template <- jsonlite::read_json(path = '../../../docs/json-ld/photovoltaicSystem-json-ld-template.json')

  # Using the function
  template <- replace_null_recursive(template)


  ## List all of the keys existing in the template
  ## Replace . with $ so R can interpret what's going on

  template_keys <- names(unlist(template))
  template_keys <- gsub('[.]', '$', template_keys)

  template_fill <- template_keys[stringr::str_which(template_keys, 'value')]
  unit_fill <- template_keys[stringr::str_which(template_keys, 'unit')]

  # Some items have a list that come out as unitText1, unitText2, etc
  template_fill <- unique(remove_adjacent_numbered_suffixes(template_fill))
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

  # Edit output template so that it only includes filled values

  # Complete list of keys and values
  complete_kv <- unlist(template)
  names(complete_kv) <- gsub('[.]', '$', names(complete_kv))

  # Including the context in this list breaks things so we remove it
  matches <- grep('context', names(complete_kv))
  complete_kv <- complete_kv[-matches]

  # Remove the value from the context
  for (x in names(complete_kv)) {

    # Skip if filled with an NA value
    if (is.na(complete_kv[[x]])) {
      next
    }

    # Detect unfilled keys
    if (stringr::str_detect(complete_kv[[x]], '\\$')) {

      # Remove the last bit of the string
      new_name <- sub("\\$[^\\$]*$", "", x)

      split_string <- strsplit(new_name, "\\$")[[1]]
      template_key_name <- split_string[length(split_string)]

      # Remove key that's empty
      eval_statement <- paste0('template$', new_name, ' <-', 'NULL')
      eval(str2expression(eval_statement))

      # Remove the key from the context
      eval_statement <- paste0('template$`@context`$', template_key_name, ' <-', 'NULL')
      eval(str2expression(eval_statement))

    }
  }

  # Depends on if the user supplied a list or not
  # Remove the value from the text body

  if (length(data_list) > 0) {

    for (key in names(complete_kv)) {

      # Remove the last bit of the string
      new_name <- sub("\\$[^\\$]*$", "", key)

      split_string <- strsplit(new_name, "\\$")[[1]]
      template_key_name <- split_string[length(split_string)]

      matches <- grep(template_key_name, names(complete_kv))
      check_value <- names(complete_kv)[matches]

      # If there isn't a match or the key doesn't have a value associated
      if (!any(grepl(paste(data_list, collapse = "|"), key)) &
          !any(stringr::str_detect(check_value, 'value'))) {

        # Remove key that's empty
        eval_statement <- paste0('template$', new_name, ' <-', 'NULL')
        eval(str2expression(eval_statement))

        # Remove the key from the context
        eval_statement <- paste0('template$`@context`$', template_key_name, ' <-', 'NULL')
        eval(str2expression(eval_statement))

      }
    }

  }


  return(jsonlite::toJSON(template, auto_unbox = TRUE))
}

#' Rename Column Names
#'
#' @param dataframe User input dataframe
#' @param domain Json-LD template to be filled by function
#'
#' @return Dataframe with FAIRified column names
#' @export
rename_fair <- function(dataframe, domain) {

  # Fix issue with R package
  template_row <- NA

  # Read in the template
  template <- jsonlite::fromJSON(get(domain))

  ## List all of the keys existing in the template
  ## Replace . with $ so R can interpret what's going on
  template_keys <- names(unlist(template))
  template_keys <- gsub('[.]', '$', template_keys)

  # Select the specific keys for alternativeIdentifier
  # Fix issue with an array in a json where R numbers things weirdly
  template_names <- template_keys[stringr::str_which(template_keys, 'alternativeIdentifier')]
  template_names <- unique(remove_adjacent_numbered_suffixes(template_names))
  template_names <- template_names[!stringr::str_detect(template_names, '@')]

  # Initialize list
  list_names <- list()

  # Make the list with each key from our json and then the alternativeIDs
  # associated with them
  for (name in template_names) {
    split_string <- strsplit(name, "\\$")[[1]]
    template_key_name <- split_string[length(split_string) - 1]

    eval_statement <- paste0('list_names <- append(list_names, list(', template_key_name, ' = template$', name, '))')
    eval(str2expression(eval_statement))
  }

  # List the input column names
  list_col <- colnames(dataframe)

  # Replace column names from user inputs to our column names
  for (col_name in list_col) {

    for (template_name in names(list_names)) {

      eval_statement <- paste0("template_row <- list_names$", template_name)

      eval(str2expression(eval_statement))

      if (col_name %in% template_row) {

        colnames(dataframe)[colnames(dataframe) == col_name] <- template_name
      }
    }
  }

  return(dataframe)
}


#' FAIRify Data
#'
#' @param dataframe User input metadata dataframe
#' @param unit_dataframe User input units (one row dataframe) \cr
#' @param domain Json-LD template to be filled by function \cr
#' @param saveLocal Boolean stating whether the files should be saved locally \cr
#' @param data_list List of columns included in any of your raw dataframes \cr
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
fairify_data <- function(dataframe, unit_dataframe = data.frame(), domain,
                         saveLocal = FALSE, data_list = list()) {

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

    json <- json_conversion(row, unit_dataframe, domain, i, data_list)

    output <- append(output, list(json))
  }

  if (saveLocal) {

    if (!file.exists('JsonFiles')) {

      dir.create('JsonFiles')
    }

    i = 1
    for (text_file in output) {

      if (any(stringr::str_detect(colnames(dataframe), 'IndividualID'))) {

        write(text_file, paste0('JsonFiles/', dataframe$IndividualID[i], '.json'))

      } else {

        write(text_file, paste0('JsonFiles/', domain, i, '.json'))

      }

      i = i + 1
    }

  }

  return(output)
}

#' This is data to be included in the package
#'
#' @name Aconity3DCharacterizationMethod
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name Aconity3DEquipment
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name Aconity3DMaterials
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name Aconity3DPrintingCondition
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name agilentFTIR
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name agilentFTIR
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name agilentFTIR
#' @docType data
#' @keywords internal
NULL

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
#' @name calibration
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
#' @name capillaryEletrophoresis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name caryUvVis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name caryUvVis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name caryUvVis
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
#' @name currentVoltage
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
#' @name fluoroelastometerFormulation
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name fluoroelastometerFormulationAFMExpMetadata
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name fluoroelastometerFormulationInstrument
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name fluoroelastometerFormulationResults
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name fluoroelastometerFormulationSamplePrep
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name gasFlux
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
#' @name icp
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name icp
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
#' @name nicoletFTIR
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name nicoletFTIR
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name nicoletFTIR
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
#' @name sampleMetadata
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name simulationXRayDiffraction
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
#' @name soilWoSis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name spectramaxUvVis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name spectramaxUvVis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name spectramaxUvVis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name streamWaterRasterio
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name waterDataUSGS
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name waterMetadataUSGS
#' @docType data
#' @keywords internal
NULL


