#' FTIR FAIR
#'
#' @description Automatically generates a .json-ld file with metadata for a given run of the FTIR instrument
#'
#' @param method_in The method that was used for the experiment run
#'
#' @return Returns a .json-ld file with desired metadata
#'
#' @examples
#' ftir_fair('method1')
#'
#' @export
ftir_fair <- function(method_in) {

  # Example metadata created for the sample

  sample_df <- data.frame('ID' = 'sa43107-es01-mn-01-ms-01',
                          'es' = 1,
                          'mn' = 1,
                          'ms' = 1,
                          'sevenid' = 'sa43107',
                          'encapsulant' = 'EVA',
                          'cell' = 'mono-Si')

  # Create the metadata for the FTIR machine itself

  machine_df <- data.frame('dtyp' = 'Spectra',
                           'tool' = 'FTIR',
                           'modi' = 'Cary 630 FTIR',
                           'pers' = 'Kunal Rath')

  # Establish the method used for the experiment (formatted this way for eventual use as a function)

  method_df <- data.frame('method' = 'ftir-atr',
                          'resolution' = 2,
                          'type' = 'Qualitative Search',
                          'cleanscans' = 4,
                          'yaxis' = 'Absorbance',
                          'apodization' = 'HappGenzel',
                          'backgroundscans' = 32,
                          'samplescans' = 32,
                          'zerofillfactor' = 'None',
                          'phasecorrect' = 'Mertz',
                          'gain' = 220,
                          'samplingtech' = 'ATR')

  ftir <- method_in

  # Read in the template .json and write the dataframe to the output

  FTIR_metadata <- glue::glue(tmp_ftir, .open = '<<', .close = '>>')

  # Output the written json file

  return(FTIR_metadata)
}










