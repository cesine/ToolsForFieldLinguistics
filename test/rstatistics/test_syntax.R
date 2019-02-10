
#testthat tests
# expect_that(object, condition, info = NULL, label = NULL)
# ask expect_that() to test the following conditions:
# is_true: Does the expression evaluate to TRUE?
# is_false: Does the expression evaluate to FALSE?
# is_a: Did the object inherit from a specified class?
# equals: Is the expression equal within numerical tolerance to your expected value?
# is_equivalent_to: Is the object equal up to attributes to your expected value?
# is_identical_to: Is the object exactly equal to your expected value?
# matches: Does a string match the specified regular expression?
# prints_text: Does the text that’s printed match the specified regular expression?
# throws_error: Does the expression raise an error?
# takes_less_than: Does the expression take less than a specified number of seconds to run?

test_that("test factorial", {
  expect_that(1 ^ 1, equals(1))
  expect_that(2 ^ 2, equals(4))
  
  expect_that(2 + 2 == 4, is_true())
  expect_that(2 == 1, is_false())
  
  expect_that(1, is_a('numeric'))
  
  expect_that(print('Hello World!'), prints_text('Hello World!'))
  
  expect_that(log('a'), throws_error())
})
