turl <- "https://athena.us-east-1.amazonaws.com"

with_mock_api({
  test_that("Correct n is POSTed", {
    expect_POST(list_athena_workgroups(), turl, '{"MaxResults":50}')
    expect_POST(list_athena_workgroups(1000), turl, '{"MaxResults":1000}')
    expect_POST(list_athena_workgroups(173), turl, '{"MaxResults":173}')
    expect_POST(list_athena_workgroups(6), turl, '{"MaxResults":6}')
  })

  test_that("list Token is POSTed", {
    corbody <- '{"MaxResults":50,"NextToken":"ttok"}'
    expect_POST(list_athena_workgroups(token = "ttok"), turl, corbody)
  })

  test_that("Get Token is POSTed", {
    corbody <- '{"WorkGroup":"primary"}'
    expect_POST(get_athena_workgroup("primary"), turl, corbody)
  })
})
