#' voteogram ggplot2 theme
#'
#' @export
theme_voteogram <- function() {

  theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank())

}