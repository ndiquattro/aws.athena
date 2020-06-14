#' AWS Athena Queries
#'
#' Get, Create, and Delete Athena Queries
#'
#' @param id A character string containing an Amazon Athena Query ID. A vector of IDs can also be specified to request multiple queries.
#' @param database Name of the database to associate with the query.
#' @param name Name of the query.
#' @param query SQL that comprises the query.
#' @param description Description of the query.
#' @param n An integer specifying the maximum number of results to return.
#' @param token A character string specifying a continuation token, for pagi
#' nation.
#' @param \dots Additional arguments passed to \code{\link{athenaHTTP}}
#' @references
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_ListNamedQueries.html}{API Reference: ListNamedQueries}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_CreateNamedQuery.html}{API Reference: CreateNamedQuery}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_GetNamedQuery.html}{API Reference: GetNamedQuery}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_BatchGetNamedQuery.html}{API Reference: BatchGetNamedQuery}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_DeleteNamedQuery.html}{API Reference: DeleteNamedQuery}
#'
#' @rdname queries
#' @export
list_athena_queries <- function(n = 50, workgroup = NULL, token = NULL, ...) {
  bod <- list()
  bod$MaxResults <- n
  bod$WorkGroup <- workgroup
  if (!is.null(token)) {
    bod$NextToken <- token
  }

  athenaHTTP("ListNamedQueries", body = bod, ...)
}

#' @rdname queries
#' @export
get_athena_query <- function(id, ...) {
  bod <- list()
  if (length(id) > 1L) {
    bod$NamedQueryIds <- id
    res <- athenaHTTP("BatchGetNamedQuery", body = bod, ...)
  } else {
    bod$NamedQueryId <- id
    res <- athenaHTTP("GetNamedQuery", body = bod, ...)
  }
  res
}

#' @rdname queries
#' @export
create_athena_query <- function(query, name, database, workgroup = NULL, description = NULL, ...) {
  bod <- list()
  bod$Name <- name
  bod$WorkGroup <- workgroup
  bod$ClientRequestToken <- uuid::UUIDgenerate()
  bod$Database <- database
  bod$QueryString <- query
  bod$Description <- description

  athenaHTTP("CreateNamedQuery", body = bod, ...)
}

#' @rdname queries
#' @export
delete_athena_query <- function(id, ...) {
  bod <- list()
  bod$NamedQueryId <- id

  invisible(athenaHTTP("DeleteNamedQuery", body = bod, ...))
}
