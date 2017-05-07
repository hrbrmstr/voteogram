#' voteogram ggplot2 theme
#'
#' @param legend if `FALSE` no legend is shown
#' @export
theme_voteogram <- function(legend=TRUE) {

  th <- theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank())

  if (!legend) th <- th + theme(legend.position="FALSE")

  th

}