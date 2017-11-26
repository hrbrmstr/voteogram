context("basic functionality")
test_that("objects are created properly", {

  t1 <- theme_voteogram()

  expect_that(t1, is_a("theme"))

  t2 <- theme_voteogram(FALSE)

  expect_that(t2, is_a("theme"))

  skip_on_cran()

  sen <- roll_call("senate", 115, 1, 110)

  expect_that(sen, is_a("pprc"))

  s1 <- senate_carto(sen)

  expect_that(s1, is_a("ggplot"))

  rep <- roll_call("house", 115, 1, 256)

  expect_that(rep, is_a("pprc"))

  hc1 <- house_carto(rep, pp_square=TRUE)

  expect_that(hc1, is_a("ggplot"))

  hc2 <- house_carto(rep, pp_square=FALSE)

  expect_that(hc2, is_a("ggplot"))

})
