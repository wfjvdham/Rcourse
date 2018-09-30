context("hello function")

test_that("it returns right value", {
  expect_equal(hello(), "Hello, world")
  expect_equal(hello(word = "moon"), "Hello, moon")
})
