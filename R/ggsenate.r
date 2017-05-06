#' Produce a Senate cartogram
#'
#' @md
#' @param a `data.frame` of vote tallys for the senate. It expects 3 columns. `state_abbrev` : the
#'     2-letter U.S. state abbreviation; `district` : either `1` or `2` to distinguish between
#'     each senator; `party` : `R`, `D` or `ID`; `position` : `yes`, `no`, `present`, `none` for
#'     how the senator voted.
#' @return a `ggplot2` object that you can further customize with scales, labels, etc.
#' @export
senate_carto <- function(vote_tally) {

  vote_tally <- mutate(vote_tally, id=sprintf("%s_%s", toupper(state_abbrev), district))
  vote_tally <- mutate(vote_tally, fill=sprintf("%s-%s", toupper(party), tolower(position)))

  plot_df <- left_join(senate_df, vote_tally, by="id")

  ggplot(plot_df) +
    geom_rect(aes(xmin=x, ymin=y, xmax=xmax, ymax=ymax, fill=fill)) +
    scale_y_reverse() +
    scale_fill_manual(name=NULL, values=vote_carto_fill) +
    theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank())

}

