#' Produce a House cartogram
#'
#' @md
#' @param vote_tally either a `pprc` object (the result of a call to [roll_call()]) or
#'     a `data.frame` of vote tallys for the house It expects 3 columns. `state_abbrev` : the
#'     2-letter U.S. state abbreviation; `district` : either `1` or `2` to distinguish between
#'     each representative; `party` : `R`, `D` or `ID`; `position` : `yes`, `no`, `present`, `none` for
#'     how the representative voted.
#' @return a `ggplot2` object that you can further customize with scales, labels, etc.
#' @export
house_carto <- function(vote_tally) {

  if (inherits(vote_tally, "pprc")) vote_tally <- vote_tally$votes
  if (!inherits(vote_tally, "data.frame")) stop("Needs a data.frame", call.=FALSE)

  cdiff <- setdiff(c("state_abbrev", "party", "district", "position"), colnames(vote_tally))
  if (length(cdiff) > 0) stop(sprintf("Missing: %s", paste0(cdiff, collapse=", ")), call.=FALSE)

  vote_tally <- dplyr::mutate(vote_tally, id=sprintf("%s_%s", toupper(state_abbrev), district))
  vote_tally <- dplyr::mutate(vote_tally, fill=sprintf("%s-%s", toupper(party), tolower(position)))
  vote_tally <- dplyr::mutate(vote_tally, fill=ifelse(grepl("acant", fill), "Vacant", fill))

  plot_df <- left_join(house_df, vote_tally, by="id")

  ggplot(plot_df) +
    geom_rect(aes(xmin=x, ymin=y, xmax=xmax, ymax=ymax, fill=fill), color="white", size=0.25) +
    scale_y_reverse() +
    scale_fill_manual(name=NULL, values=vote_carto_fill) +
    theme(panel.background=element_blank()) +
    theme(panel.grid=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank())

}
