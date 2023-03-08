#' Produce a ProPublica- or GovTrack-style House roll call vote cartogram
#'
#' @md
#' @param vote_tally either a `pprc` object (the result of a call to [roll_call()]) or
#'     a `data.frame` of vote tallies for the house It expects 3 columns. `state_abbrev` : the
#'     2-letter U.S. state abbreviation; `district` : either `1` or `2` to distinguish between
#'     each representative; `party` : `R`, `D` or `ID`; `position` : `yes`, `no`, `present`, `none` for
#'     how the representative voted.
#' @param style either ProPublica-ish (`pp` or `propublica`) or GovTrack-ish (`gt` or `govtrack`)
#' @param pp_square if `TRUE` then no "state borders" will be drawn, but distinct Representative
#'     squares. If `FALSE` then the cartogram will be very close to the ProPublica cartograms.
#' @return a `ggplot2` object that you can further customize with scales, labels, etc.
#' @note No "themeing" is applied to the returned ggplot2 object. You can use  [theme_voteogram()]
#'     if you need a base theme. Also, GovTrack-style cartograms will have `coord_equal()`
#'     applied by default.
#' @export
#' @examples \dontrun{
#' # what you'd normally do
#' rep <- roll_call("house", 115, 1, 256)
#' }
#'
#' # using a saved object
#' rep <- readRDS(system.file("extdata", "rep.rds", package = "voteogram"))
#'
#' house_carto(rep, pp_square = TRUE)
house_carto <- function(vote_tally, style = c("pp", "gt", "propublica", "govtrack"), pp_square = FALSE) {
  if (inherits(vote_tally, "pprc")) vote_tally <- vote_tally$votes
  if (!inherits(vote_tally, "data.frame")) stop("Needs a data.frame", call. = FALSE)

  style <- match.arg(tolower(style), c("pp", "gt", "propublica", "govtrack"))

  cdiff <- setdiff(c("state_abbrev", "party", "district", "position"), colnames(vote_tally))
  if (length(cdiff) > 0) stop(sprintf("Missing: %s", paste0(cdiff, collapse = ", ")), call. = FALSE)

  if (style %in% c("pp", "propublica")) {
    vote_tally <- dplyr::mutate(vote_tally, id = sprintf("%s_%s", toupper(state_abbrev), district))
    vote_tally <- dplyr::mutate(vote_tally, fill = sprintf("%s-%s", toupper(party), tolower(position)))
    vote_tally <- dplyr::mutate(vote_tally, fill = ifelse(grepl("acant", fill), "Vacant", fill))

    plot_df <- dplyr::left_join(house_df, vote_tally, by = "id")

    if (pp_square) {
      ggplot(plot_df) +
        geom_rect(
          aes(
            xmin = x,
            ymin = y,
            xmax = xmax,
            ymax = ymax,
            fill = fill
          ),
          color = "white",
          linewidth = 0.25
        ) +
        scale_y_reverse() +
        scale_fill_manual(
          name = NULL,
          values = vote_carto_fill
        ) +
        labs(x = NULL, y = NULL)
    } else {
      ggplot() +
        geom_rect(
          data = plot_df,
          aes(
            xmin = x,
            ymin = y,
            xmax = xmax,
            ymax = ymax,
            fill = fill,
            color = fill
          ),
          linewidth = 0.25
        ) +
        geom_line(
          data = house_lines,
          aes(x, y, group = id),
          color = "white",
          lineend = "round",
          linejoin = "round",
          linewidth = 0.5
        ) +
        scale_y_reverse() +
        scale_color_manual(
          name = NULL,
          values = vote_carto_color
        ) +
        scale_fill_manual(
          name = NULL,
          values = vote_carto_fill
        ) +
        labs(x = NULL, y = NULL)
    }
  } else {
    zeroes <- c("ak", "as", "dc", "de", "gu", "mp", "mt", "nd", "pr", "sd", "vi", "vt", "wy")

    vote_tally <- dplyr::mutate(vote_tally, district = ifelse(tolower(state_abbrev) %in% zeroes, 0, district))
    vote_tally <- dplyr::mutate(vote_tally, id = sprintf("%s%02d", tolower(state_abbrev), district))
    vote_tally <- dplyr::mutate(vote_tally, fill = sprintf("%s-%s", toupper(party), tolower(position)))
    vote_tally <- dplyr::mutate(vote_tally, fill = ifelse(grepl("acant", fill), "Vacant", fill))

    plot_df <- dplyr::left_join(gt_house_polys, vote_tally, by = "id")
    plot_df <- dplyr::filter(plot_df, !is.na(fill))

    ggplot() +
      geom_polygon(
        data = plot_df,
        aes(x, y, group = id, fill = fill),
        linewidth = 0
      ) +
      geom_line(
        data = gt_house_lines,
        aes(x, y, group = id),
        linewidth = gt_house_lines$size,
        color = gt_house_lines$color,
        lineend = "round",
        linejoin = "round"
      ) +
      geom_text(
        data = gt_house_labs,
        aes(x, y, label = lab),
        size = 2.25,
        hjust = 0,
        vjust = 0
      ) +
      scale_y_reverse() +
      scale_fill_manual(
        name = NULL,
        values = vote_carto_fill,
        na.value = "white"
      ) +
      coord_equal() +
      labs(x = NULL, y = NULL)
  }
}
