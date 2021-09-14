#' IVAllReal FAIR
#'
#' @description Automatically generates a .json-ld file with metadata for a given run of the IVAllReal instrument
#'
#' @param method_in The method that was used for the experiment run
#'
#' @return Returns a .json-ld file with desired metadata
#'
#' @examples
#' ivallreal_fair('li-cor')
#'
#' @importFrom dplyr %>%
#'
#' @export
ivallreal_fair <- function(method_in) {

  method <- NULL

  # Create the metadata for the IVAR machine itself

  machine_df <- data.frame('datatype' = 'Electrical',
                           'tool' = 'AllReal',
                           'instrumentmodel' = 'AllReal Solo Apollo',
                           'person' = 'Jiqi',
                           'fullloadcurrent' = '30A',
                           'maxpower' = '10kW',
                           'shortcircuitrating' = '7.5kA',
                           'manufacturedate' = '2011-11')

  # Establish the method used for the experiment (formatted this way for eventual use as a function)

  sample_name <- 'sa43003_01'
  measurement_date <- '2014-5-15'

  method_df <- data.frame('method' = c('li-cor', 'c-Si'),
                          'SNnumber' = c('py27559', 'ARC-05-M-Q-007'),
                          'referenceirradiance' = c(1000, 1000),
                          'voltageoutput' = c(0.0085, 0.53),
                          'referencetemperature' = c(25, 25),
                          'alpha' = c(0, 0),
                          'temperaturesource' = c('TEMP2', 'TEMP2'),
                          'xaxis' = c('Voltage', 'Voltage'),
                          'yaxis' = c('Current', 'Current'))

  specific_method <- method_df %>%
    dplyr::filter(method == method_in)

  # Read in the template .json and write the dataframe to the output

  IVAllReal_metadata <- glue::glue(tmp_ivallreal, .open = '<<', .close = '>>')

  # Output the .json

  return(IVAllReal_metadata)
}
