with_mock_api({
  test_that("Body is added to request", {
    expect_POST(
      athenaHTTP("ListWorkGroups", body = list(TestIt = "testing")),
      "https://athena.us-east-1.amazonaws.com",
      '{\"TestIt\":\"testing\"}'
    )
  })
})
