#' AWS Athena Workgroups
#'
#' Get Athena Workgroups
#'
#' @param workgroup A character string containing the workgroup's name.
#' @param n An integer specifying the maximum number of results to return.
#' @param token A character string specifying a continuation token, for pagi
#' nation.
#' @param \dots Additional arguments passed to \code{\link{athenaHTTP}}
#'
#' @references
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_ListWorkGroups.html}{API Reference: ListWorkGroups}
#'  \href{https://docs.aws.amazon.com/athena/latest/APIReference/API_GetWorkGroup.html}{API Reference: GetWorkGroup}
#'
#' @rdname workgroups
#'
#' @export
list_athena_workgroups <- function(n = 50, token = NULL, ...) {
  bod <- list()
  bod$MaxResults <- n
  if (!is.null(token)) {
    bod$NextToken <- token
  }

  athenaHTTP("ListWorkGroups", body = bod, ...)
}

#' @rdname workgroups
#' @export
get_athena_workgroup <- function(workgroup, ...) {
  bod <- list()
  bod$WorkGroup <- workgroup

  athenaHTTP("GetWorkGroup", body = bod, ...)
}
