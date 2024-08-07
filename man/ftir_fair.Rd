% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ftir_fair.R
\name{ftir_fair}
\alias{ftir_fair}
\title{FTIR FAIR}
\usage{
ftir_fair(method_in)
}
\arguments{
\item{method_in}{The method that was used for the experiment run}
}
\value{
Returns a .json-ld file with desired metadata
}
\description{
Automatically generates a .json-ld file with metadata for a given run of the FTIR instrument
}
\examples{
ftir_fair('method1')

}
