#' Convert Dataframe to Json from a Template
#'
#' @param row Row of a user input csv that includes metadata
#' @param domain Json-LD template to be filled by function
#'
#' @return FAIRified .json-ld text document
json_conversion <- function(row, domain) {

  ## Read in the template (on release this will be read from sysdata.rda)

  # Read in the template from the sysdata.rda file
  template <- jsonlite::fromJSON(get(domain))
  #template <- jsonlite::read_json(path = 'pv-module.json')
  #template <- jsonlite::read_json(path = '../../../../docs/json-ld/pv-module.json')

  ## List all of the keys existing in the template
  ## Replace . with $ so R can interpret what's going on

  template_keys <- names(unlist(template))
  template_keys <- gsub('[.]', '$', template_keys)

  template_fill <- template_keys[stringr::str_which(template_keys, 'value')]

  # Fill json template

  for (x in colnames(row)) {

    if (any(stringr::str_detect(template_fill, x)) == TRUE) {

      key <- template_fill[stringr::str_which(template_fill, x)]

      if (inherits(row[[x]], 'character')) {

        eval_statement <- paste0('template$', key, ' <-', '"', row[[x]], '"')
      } else {

        eval_statement <- paste0('template$', key, ' <-', row[[x]])
      }

    } else {   # Let the user add a new key in the additional properties section

      if (inherits(row[[x]], 'character')) {

        eval_statement <- paste0('template$additionalProperty$', x, ' <-', '"', row[[x]], '"')
      } else {

        eval_statement <- paste0('template$additionalProperty$', x, ' <-', row[[x]])
      }

    }

    eval(str2expression(eval_statement))
  }

  return(jsonlite::toJSON(template, auto_unbox = TRUE))
}


#' FAIRify Data
#'
#' @param dataframe User input metadata dataframe
#' @param domain Json-LD template to be filled by function \cr
#' @param saveLocal Boolean stating whether the files should be saved locally \cr
#' User can FAIRify data in the following domains: \cr \cr
#' PVModule \cr
#' Buildings \cr
#' CapillaryElectrophoresis \cr
#' GeospatialWell \cr
#' MetalAM \cr
#' OpticalProfilometry \cr
#' OpticalSpectroscopy \cr
#' PolymerAM \cr
#' PolymerBacksheets \cr
#' PVModule \cr
#' PVSystem \cr
#' XCT \cr
#' XRD
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
#'                        'EncapsulantMaterial = EVA')
#'
#' fairify_data(metadata, domain = 'PVModule', saveLocal = FALSE)
fairify_data <- function(dataframe, domain, saveLocal = FALSE) {

  output <- list()

  for(i in 1:nrow(dataframe)) {
    row <- dataframe[i,]

    json <- json_conversion(row, domain)

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
#' @name CapillaryElectrophoresis
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name GeospatialWell
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name MetalAM
#' @docType data
#' @keywords internal
NULL


#' This is data to be included in the package
#'
#' @name OpticalProfilometry
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name OpticalSpectroscopy
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name PVModule
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name PVSystem
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name PolymerAM
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name PolymerBacksheets
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name XCT
#' @docType data
#' @keywords internal
NULL

#' This is data to be included in the package
#'
#' @name XRD
#' @docType data
#' @keywords internal
NULL
