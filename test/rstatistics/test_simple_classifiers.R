source("../../src/rstatistics/spam.r")

debug <- FALSE

test_that("test demoSimpleSpamClassifiers loads", {
  print("test demoSimpleSpamClassifiers loads")
  expect_that(class(demoSimpleSpamClassifiers), equals("function"))
  })


test_that("test demoSimpleSpamClassifiers returns a confusion matrix", {
  print("test demoSimpleSpamClassifiers returns a confusion matrix")

  # expect_that(class(demoSimpleSpamClassifiers), equals("function"))
  
  x <- demoSimpleSpamClassifiers(debug)
  if(debug) {
    print(x)
  }

  accuracy <- x["accuracy"]
  expectedAccuracy <- 0.7513584
  if(debug) {
    print(paste(expectedAccuracy, " is ", accuracy))
  }
  expect_that(accuracy, is_equivalent_to(expectedAccuracy))
  expect_that(x["accuracy"], is_equivalent_to(0.7513584))
})
