#' Powerplant FAIR
#'
#' @description Given a table of metadata, this function generates a .json-ld file with the metadata for a solar powerplant
#'
#' @param specific_data This is a dataframe with specially formatted metadata
#'
#' @return Returns a .json-ld file with desired metadata
#'
#' @examples
#' powerplant_fair(test_metadata)
#'
#' @export
powerplant_fair <- function(specific_data) {

  # Read in the template .json and write the dataframe to the output

  powerplant_metadata <- glue::glue(tmp_powerplant, .open = '<<', .close = '>>')

  # Output the .json

  return(powerplant_metadata)
}
