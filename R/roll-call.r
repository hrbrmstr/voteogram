#' Get Voting Record for House or Senate By Number, Session & Roll Call Number
#'
#' @param critter one of `house` or `senate`
#' @param number valid congress number (e.g. `115`)
#' @param session a valid session numbner (i.e. `1` or `2` and valid for current year)
#' @param rcall roll call vote number
#' @export
roll_call <- function(critter = c("house", "senate"), number, session = c(1L,2L), rcall) {

  critter <-  match.arg(tolower(critter), c("house", "senate"))
  number <- as.integer(number)
  session <- as.integer(session)
  rcall <- as.integer(rcall)

  base_url <- "https://pp-projects-static.s3.amazonaws.com/congress/assets/%s_%s_%s_%s.json"
  base_url <- sprintf(base_url, critter, number, session, rcall)

  res <- jsonlite::fromJSON(base_url)
  res$votes <- tbl_df(res$votes)

  class(res) <- c("pprc", class(res))

  res

}

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