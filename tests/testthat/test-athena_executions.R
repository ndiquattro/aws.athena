turl <- "https://athena.us-east-1.amazonaws.com"

with_mock_api({
  test_that("list executions passes parameters", {
    cor_body <- '{"MaxResults":100,"WorkGroup":"primary","NextToken":"ttok"}'

    expect_POST(list_athena_executions(100, "ttok", "primary"), turl, cor_body)
  })

  test_that("Stop execution request is formed correctly", {
    cor_body <- '{"QueryExecutionId":"abc-123"}'

    expect_POST(stop_athena_execution("abc-123"), turl, cor_body)
  })

  test_that("single vs. multiple IDs are handled correctly", {
    tid <- "abc-123"
    tids <- c("abc-123", "def-456")

    expect_header(expect_POST(get_athena_execution(tid)), "X-Amz-Target: AmazonAthena.GetQueryExecution")
    expect_header(expect_POST(get_athena_execution(tids)), "X-Amz-Target: AmazonAthena.BatchGetQueryExecution")

    ids_bod <- '{"QueryExecutionIds":["abc-123","def-456"]}'
    expect_POST(get_athena_execution(tid), turl, '{"QueryExecutionId":"abc-123"}')
    expect_POST(get_athena_execution(tids), turl, ids_bod)
  })

  test_that("start execution passes parameters", {
    exp_body <- '\\{"WorkGroup":"primary","ClientRequestToken":".+","QueryString":"SELECT \\* FROM sch.tab","ResultConfiguration":\\{"OutputLocation":"s3://tbucket"\\},"QueryExecutionContext":\\{"Database":"db"\\}\\}'
    expect_POST(start_athena_execution("SELECT * FROM sch.tab", "primary", "db", "s3://tbucket", "enc"), turl, exp_body, fixed = FALSE)
  })
})
