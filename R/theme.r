#' voteogram ggplot2 theme
#'
#' Provides a very basic theme with no background, grid, axis text or axis ticks and
#' an easy way to turn the legend on or off.
#'
#' @param legend if `FALSE` no legend is shown
#' @export
#' @examples \dontrun{
#' # what you'd normally do
#' sen <- roll_call("senate", 115, 1, 110)
#' }
#'
#' # using a saved object
#' sen <- readRDS(system.file("extdata", "sen.rds", package="voteogram"))
#'
#' senate_carto(sen) +
#'   theme_voteogram()
theme_voteogram <- function(legend=TRUE) {

  theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank()) -> th

  if (!legend) th <- th + theme(legend.position="FALSE")

  th

}