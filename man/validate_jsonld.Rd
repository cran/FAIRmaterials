% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/external_functions.R
\name{validate_jsonld}
\alias{validate_jsonld}
\title{Validate Json-ld}
\usage{
validate_jsonld(json_file)
}
\arguments{
\item{json_file}{Json-ld created from the fairify_data function}
}
\value{
Returns a prompt that says whether or not a json-ld is valid
}
\description{
Validate Json-ld
}
\examples{
test_pass <- '{
"@context": "http://schema.org/",
"@type": "Person",
"name": "Jane Doe",
"jobTitle": "Professor",
"telephone": "(425) 123-4567",
"url": "http://www.janedoe.com"}'

#validate_jsonld(test_pass)
}
