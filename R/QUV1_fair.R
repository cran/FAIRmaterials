#' QUV1 FAIR
#'
#' @description Automatically generates a .json-ld file with metadata for a given run of the QUV1 instrument
#'
#' @param method_in The method that was used for the experiment run
#'
#' @return Returns a .json-ld file with desired metadata
#'
#' @examples
#' QUV1_fair('hot-quv')
#'
#' @importFrom dplyr %>%
#'
#' @export
QUV1_fair <- function(method_in) {

  metd <- NULL

  # Create the metadata for the QUV machine itself

  machine_df <- data.frame('tool' = 'Exposure Chamber',
                           'modi' = 'QUV1',
                           'pers' = 'Kunal')

  # Establish the method used for the experiment

  total_time_in <- 65000
  step_time_in <- "0:30"
  total_time_out <- 65023
  step_time_out <- "0:28"


  method_df <- data.frame('metd' = c('hot-quv', 'cyclic-quv'),
                          'temp' = c('static', 'cyclic')) #always 70 for hot quv; either for cyclic...

  specific_method <- method_df %>%
    dplyr::filter(metd == method_in)

  # Read in the template .json and write the dataframe to the output

  QUV1_metadata <- glue::glue(tmp_QUV1, .open = '<<', .close = '>>')

  # Output the .json

  return(QUV1_metadata)
}
