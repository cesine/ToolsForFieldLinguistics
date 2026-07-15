library(testthat)
source(if (file.exists("src/rstatistics/spam.r")) "src/rstatistics/spam.r" else "../../src/rstatistics/spam.r")

debug <- FALSE

test_that("test demoSimpleSpamClassifiers loads", {
  print("test demoSimpleSpamClassifiers loads")
  expect_equal(class(demoSimpleSpamClassifiers), "function")
  })


test_that("test demoSimpleSpamClassifiers returns a confusion matrix", {
  print("test demoSimpleSpamClassifiers returns a confusion matrix")

  # expect_equal(class(demoSimpleSpamClassifiers), "function")
  
  x <- demoSimpleSpamClassifiers(debug)
  if(debug) {
    print(x)
  }

  accuracy <- x["accuracy"]
  expectedAccuracy <- 0.7513584
  if(debug) {
    print(paste(expectedAccuracy, " is ", accuracy))
  }
  expect_equivalent(accuracy, expectedAccuracy)
  expect_equivalent(x["accuracy"], 0.7513584)
})
