#' SunsVoc FAIR
#'
#' @description Automatically generates a .json-ld file with metadata for a given run of the SunsVoc instrument
#'
#' @param method_in The method that was used for the experiment run
#'
#' @return Returns a .json-ld file with desired metadata
#'
#' @examples
#' sunsvoc_fair('default.svi')
#'
#' @importFrom dplyr %>%
#'
#' @export
sunsvoc_fair <- function(method_in) {

  metd <- NULL

  # Create the metadata for the SunsVoc machine itself

  machine_df <- data.frame('dtyp' = 'electrical',
                           'tool' = 'Suns Voc',
                           'modi' = 'Solar Apollo',
                           'modn' = 'SS037047',
                           'sern' = 'US0020011111',
                           'inpv' = '220, 3, 30/60',
                           'flc' = 30,
                           'mpow' = 10,
                           'scr' = 7.5,
                           'mand' = '2011-11',
                           'pers' = 'Sameera, Jiqi')

  # Establish the method used for the experiment (formatted this way for eventual use as a function)

  method_df <- data.frame ('metd' = c('default.svi', 'DPVSmonoAIBSF.svi', 'DPVSmonoPERC.svi', 'mono-DPVS.svi'),
                           'bid' = c('none', '1710-11', '1710-11', '1709-20_BL'),
                           'sid' = c('none', 'none', 'none', 'none'),
                           'jsc' = c(0.035, 0.0338, 0.0344, 0.035),
                           'ncel' = c(1, 1, 1, 1),
                           'thck' = c(0.02, 0.018, 0.017, 0.02),
                           'bres' = c(2, 2.4, 2.25, 1),
                           'samt' = c('p-type', 'p-type', 'p-type', 'p-type'),
                           'anty' = c('generalized', 'generalized', 'generalized', 'generalized'),
                           'sern' = c('10-125917', '10-125917', '10-125917', '10-125917'),
                           'rcell' = c(0.105967, 0.105967, 0.105967, 0.105967),
                           'augc' = c(1.66E-30, 1.66E-30, 1.66E-30, 1.66E-30),
                           'temc'= c(0.0022, 0.0022, 0.0022, 0.0022),
                           'augm'= c('Sinton', 'Sinton', 'Sinton', 'Sinton'),
                           'bna' = c('off', 'off', 'off', 'off'),
                           'qss' = c('1300', '1300', '1300', '1300'),
                           'oset' = c('Autoscale graphs after measurement', 'Autoscale graphs after measurement', 'Autoscale graphs after measurement', 'Autoscale graphs after measurement' ))


  specific_method <- method_df %>%
    dplyr::filter(metd == method_in)

  # Read in the template .json and write the dataframe to the output

  SunsVoc_metadata <- glue::glue(tmp_sunsvoc, .open = '<<', .close = '>>')

  # Output the .json

  return(SunsVoc_metadata)
}
