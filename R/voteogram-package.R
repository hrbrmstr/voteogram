#' U.S. House and Senate Voting Cartogram Generators
#'
#' ProPublica' <https://projects.propublica.org/represent/> makes United States
#' Congress member votes available and has developed their own unique cartogram to visually
#' represent this data. Tools are provided to retrieve voting data, prepare voting data
#' for plotting with 'ggplot2', create vote cartograms and theme them.
#'
#' @name voteogram
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import ggplot2
#' @importFrom dplyr left_join mutate tbl_df filter %>%
#' @importFrom jsonlite fromJSON
#' @importFrom scales ordinal
#' @importFrom utils globalVariables
NULL


#' voteogram exported operators
#'
#' The following functions are imported and then re-exported
#' from the voteogram package to enable use of the magrittr
#' pipe operator with no additional library calls
#'
#' @name voteogram-exports
NULL

#' @name %>%
#' @export
#' @rdname voteogram-exports
NULL