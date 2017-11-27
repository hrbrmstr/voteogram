context("basic functionality")
test_that("objects are created properly", {

  t1 <- theme_voteogram()
  expect_that(t1, is_a("theme"))

  t2 <- theme_voteogram(FALSE)
  expect_that(t2, is_a("theme"))

  sen <- readRDS(system.file("extdata", "sen.rds", package="voteogram"))
  rep <- readRDS(system.file("extdata", "rep.rds", package="voteogram"))

  hc1 <- house_carto(rep, pp_square=TRUE)
  expect_that(hc1, is_a("ggplot"))

  hc2 <- house_carto(rep, pp_square=FALSE)
  expect_that(hc2, is_a("ggplot"))

  s1 <- senate_carto(sen)
  expect_that(s1, is_a("ggplot"))

  skip_on_cran() # these make API calls

  sen <- roll_call("senate", 115, 1, 110)
  expect_that(sen, is_a("pprc"))

  rep <- roll_call("house", 115, 1, 256)
  expect_that(rep, is_a("pprc"))

})
