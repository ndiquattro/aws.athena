turl <- "https://athena.us-east-1.amazonaws.com"

with_mock_api({
  test_that("list executions passes parameters", {
    cor_body <- '{"MaxResults":100,"WorkGroup":"primary","NextToken":"ttok"}'

    expect_POST(list_athena_executions(100, "ttok", "primary"), turl, cor_body)
  })

  test_that("Stop execution request is formed correctly", {
    cor_body <- '{"QueryExecutionId":"fjdklaf-daf134"}'

    # expect_POST(stop_athena_execution("fjdklaf-daf134"), turl, cor_body)
    expect_header(stop_athena_execution("fjdklaf-daf134"),
                  "X-Amz-Target: AmazonAthena.StopQueryExecution")
  })
})
