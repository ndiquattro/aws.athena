% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/athenaHTTP.R
\name{athenaHTTP}
\alias{athenaHTTP}
\title{API Requests}
\usage{
athenaHTTP(
  action,
  headers = list(),
  query = list(),
  body = NULL,
  verbose = getOption("verbose", FALSE),
  region = NULL,
  key = NULL,
  secret = NULL,
  session_token = NULL,
  ...
)
}
\arguments{
\item{action}{A character string specifying an API endpoint.}

\item{headers}{A list of headers to pass to the HTTP request.}

\item{query}{An optional named list containing query string parameters and
their character values.}

\item{body}{A request body}

\item{verbose}{A logical indicating whether to be verbose. Default is given
by \code{options("verbose")}.}

\item{region}{A character string specifying an AWS region. See
\code{\link[aws.signature]{locate_credentials}}.}

\item{key}{A character string specifying an AWS Access Key. See
\code{\link[aws.signature]{locate_credentials}}.}

\item{secret}{A character string specifying an AWS Secret Key. See
\code{\link[aws.signature]{locate_credentials}}.}

\item{session_token}{Optionally, a character string specifying an AWS
temporary Session Token to use in signing a request. See
\code{\link[aws.signature]{locate_credentials}}.}

\item{...}{Additional arguments passed to \code{\link[httr]{GET}}.}
}
\value{
If successful, a named list. Otherwise, a data structure of class
\dQuote{aws-error} containing any error message(s) from AWS and information
about the request attempt.
}
\description{
Amazon Athena HTTP Requests
}
\details{
This function constructs and signs an Athena API request and returns the
results thereof, or relevant debugging information in the case of error.
}
\author{
Thomas J. Leeper
}
