% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ivallreal_fair.R
\name{ivallreal_fair}
\alias{ivallreal_fair}
\title{IVAllReal FAIR}
\usage{
ivallreal_fair(method_in)
}
\arguments{
\item{method_in}{The method that was used for the experiment run}
}
\value{
Returns a .json-ld file with desired metadata
}
\description{
Automatically generates a .json-ld file with metadata for a given run of the IVAllReal instrument
}
\examples{
ivallreal_fair('li-cor')

}
