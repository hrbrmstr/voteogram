#' voteogram ggplot2 theme
#'
#' Provides a very basic theme with no background, grid, axis text or axis ticks and
#' an easy way to turn the legend on or off.
#'
#' @param legend if `FALSE` no legend is shown
#' @export
#' @examples \dontrun{
#' sen <- roll_call("senate", 115, 1, 110)
#' senate_carto(sen) +
#'   labs(title="Senate Vote 110 - Invokes Cloture on Neil Gorsuch Nomination") +
#'   theme_ipsum_rc(plot_title_size = 24) +
#'   theme_voteogram()
#' }
theme_voteogram <- function(legend=TRUE) {

  theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank()) -> th

  if (!legend) th <- th + theme(legend.position="FALSE")

  th

}