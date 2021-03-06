#' Create bounding coordinates for map making
#' @param df An sf data frame for which sensible bounding coords are needed
#' @return 'xlim' and 'ylim' -- x and y coordinates for the extremes of the map
#' @export
boundMap <- function(df) {
  sfbbox <- st_bbox(df)
  bbox <- unname(sfbbox)
  xlim <- c(bbox[1], bbox[3]) # puts the coords into the order expected down in ggmap coords
  ylim <- c(bbox[2], bbox[4])
  # return(xlim, ylim)
  assign('xlim', xlim,envir=.GlobalEnv)
  assign('ylim',ylim,envir=.GlobalEnv)
}

