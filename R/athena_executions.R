#' AWS Athena Executions
#'
#' Get, Start, and Stop Athena Query Executions
#'
#' @param id A character string containing an Amazon Athena Query Executionn ID. A vector of IDs can also be specified to request multiple query executions.
#' @param workgroup A character string containing the workgroup's name.
#' @param database Name of the database to associate with the query.
#' @param n An integer specifying the maximum number of results to return.
#' @param token A character string specifying a continuation token, for pagination.
#' @param \dots Additional arguments passed to \code{\link{athenaHTTP}}
#'
#' @references
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_ListQueryExecutions.html}{API Reference: ListQueryExecutions}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_GetQueryExecution.html}{API Reference: GetQueryExecution}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_BatchGetQueryExecution.html}{API Reference: BatchGetQueryExecution}
#'
#' @rdname executions
#' @export
#'
#' @examples
#' \dontrun{
#' require("aws.s3")
#' b <- aws.s3::put_bucket("aws-athena-r-demo")
#'
#' # create an Athena database
#' id <- start_athena_execution(
#'   query = "create database DEMO",
#'   output = "s3://aws-athena-r-demo"
#' )
#'
#' # create a table in the database
#' }
list_athena_executions <- function(n = 50, token = NULL, workgroup = NULL, ...) {
  bod <- list()
  bod$MaxResults <- n
  bod$WorkGroup <- workgroup
  if (!is.null(token)) {
    bod$NextToken <- token
  }

  athenaHTTP("ListQueryExecutions", body = bod, ...)
}

#' @rdname executions
#' @export
get_athena_execution <- function(id, ...) {
  bod <- list()
  if (length(id) > 1L) {
    bod$QueryExecutionIds <- id
    res <- athenaHTTP("BatchGetQueryExecution", body = bod, ...)
  } else {
    bod$QueryExecutionId <- id
    res <- athenaHTTP("GetQueryExecution", body = bod, ...)
  }

  res
}

#' @rdname executions
#' @export
start_athena_execution <- function(query, workgroup = NULL, database = NULL, output = NULL, encryption = NULL, ...) {
  bod <- list()
  bod$WorkGroup <- workgroup
  bod$ClientRequestToken <- paste(sample.int(32), collapse = "")
  bod$QueryString <- query
  bod$ResultConfiguration$EncryptionConfiguration <- encryption
  if (!is.null(database)) bod$QueryExecutionContext <- list(Database = database)
  if (!is.null(output)) bod$ResultConfiguration <- list(OutputLocation = output)

  athenaHTTP("StartQueryExecution", body = bod, ...)
}

#' @rdname executions
#' @export
stop_athena_execution <- function(id, ...) {
  bod <- list()
  bod$QueryExecutionId <- id

  athenaHTTP("StopQueryExecution", body = bod, ...)
}
