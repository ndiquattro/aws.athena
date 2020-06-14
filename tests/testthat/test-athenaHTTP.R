with_mock_api({
  test_that("Body is added to request", {

    expect_POST(
      athenaHTTP("ListWorkGroups", body = list(TestIt = "testing")),
      "https://athena.us-east-1.amazonaws.com",
      '{\"TestIt\":\"testing\"}'
    )
  })

  test_that("Correct action is mapped", {
    exp_h <- "X-Amz-Target: AmazonAthena.ListWorkGroups"

    expect_header(expect_POST(athenaHTTP("ListWorkGroups")), exp_h)
  })

})

test_that("Errors are parsed", {

  expect_output(
    expect_warning(out <- athenaHTTP("zz"))
  )

  expect_s3_class(out, "aws_error")
  expect_equal(out$`__type`, "UnknownOperationException")
})
