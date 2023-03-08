#' Get Voting Record for House or Senate By Number, Session & Roll Call Number
#'
#' @param critter one of `house` or `senate`
#' @param number valid congress number. ProPublica seems to have data going back to the 101st
#'     Congress, so valid values are `101`-present Congress number (`115` as of the creation
#'     date of the package).
#' @param session a valid session numbner (i.e. `1` or `2` and valid for current year)
#' @param rcall roll call vote number
#' @return a `list`, one component of which is a `votes` `data.frame`
#' @note Try to cache this data if at all possible. ProPublica is a non-profit organization
#'     and this data comes from their Amazon S3 buckets. Every access in a given month
#'     ticks down the "free" counter.
#' @export
#' @examples \dontrun{
#' # these make API calls so they aren't run in the examples
#' rep <- roll_call("house", 115, 1, 256)
#' sen <- roll_call("senate", 115, 1, 110)
#' }
roll_call <- function(critter = c("house", "senate"), number, session = c(1L,2L), rcall) {

  critter <-  match.arg(tolower(critter), c("house", "senate"))
  session <- as.integer(match.arg(as.character(session), as.character(1:2)))

  number <- as.integer(number)
  if (number < 101L) stop("ProPublica does not have data going that far back", call.=FALSE)

  rcall <- as.integer(rcall)

  base_url <- "https://pp-projects-static.s3.amazonaws.com/congress/assets/%s_%s_%s_%s.json"
  base_url <- sprintf(base_url, critter, number, session, rcall)

  res <- jsonlite::fromJSON(base_url)
  res$votes <- tibble::as_tibble(res$votes)

  class(res) <- c("pprc", class(res))

  res

}

#' Fortify a [roll_call()] (`pprc`) object
#'
#' @md
#' @param model a [roll_call()] (`pprc`) object
#' @param data unused
#' @param ... unused
#' @export
fortify.pprc <- function(model, data, ...) { model$votes }

#' Better default `print` function for [roll_call()] (`pprc`) objects
#'
#' @md
#' @param x a [roll_call()] (`pprc`) object
#' @param ... ignored
#' @export
print.pprc <- function(x, ...) {

  cat(sprintf("%s Congress / Session: %s / %s Roll Call: %s / %s\n\n%s\n\nResult: %s\n",
              scales::ordinal(x$congress), x$session, x$chamber, x$roll_call, x$date_of_vote,
              if (x$description == "") x$question else x$description ,
              x$result))

}