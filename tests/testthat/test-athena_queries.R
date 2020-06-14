turl <- "https://athena.us-east-1.amazonaws.com"

with_mock_api({
  test_that("List queries passes parameters", {
    cor_body <- '{"MaxResults":100,"WorkGroup":"primary","NextToken":"ttok"}'

    expect_POST(list_athena_queries(100, "primary", "ttok"), turl, cor_body)
  })

  test_that("Delete query request is formed correctly", {
    cor_body <- '{"NamedQueryId":"abc-123"}'

    expect_POST(delete_athena_query("abc-123"), turl, cor_body)
  })

  test_that("Single vs. multiple IDs are handled correctly", {
    tid <- "abc-123"
    tids <- c("abc-123", "def-456")

    expect_header(expect_POST(get_athena_query(tid)), "X-Amz-Target: AmazonAthena.GetNamedQuery")
    expect_header(expect_POST(get_athena_query(tids)), "X-Amz-Target: AmazonAthena.BatchGetNamedQuery")

    ids_bod <- '{"NamedQueryIds":["abc-123","def-456"]}'
    expect_POST(get_athena_query(tid), turl, '{"NamedQueryId":"abc-123"}')
    expect_POST(get_athena_query(tids), turl, ids_bod)
  })

  test_that("Create named query passes parameters", {
    exp_body <- '\\{"Name":"tname","WorkGroup":"db","ClientRequestToken":".+","Database":"primary","QueryString":"SELECT \\* FROM sch.tab","Description":"a test query"\\}'

    expect_POST(create_athena_query("SELECT * FROM sch.tab", "tname", "primary", "db", "a test query"), turl, exp_body, fixed = FALSE)
  })
})
