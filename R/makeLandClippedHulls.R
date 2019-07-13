#' Creates convex hulls which are clipped to landmasses
#'
#' \code{makeLandClippedHulls} returns the clipped convex hulls by species for a
#' single object of class sf (a data frame).
#'
#'  CHECK THIS I MIGHT HAVE FIXED THAT
#'
#' A warning message will appear for \code{st_intersection}, which is correct,
#' however so long as the crs of your \code{geometry} column is
#' longitude/latitude (4326) it is of no consequence.
#'
#' These hulls are clipped to landmasses only. \code{x} must have
#' both a \code{geometry} and a \code{binomial} column present to work.
#'
#' For more felxible convex hull generation see \link[sf]{st_convex_hull}
#'
#' Landmasses used to clip to are generated from the \code{rnaturalearth}
#' package using the \code{ne_countries} function. please see its documentation
#' here \link[rnaturalearth]{ne_countries} for a full breakdown.
#' @param x object of class sf, sfc or sfg
#' @return An object (\code{x}) of class sf, sfc or sfg with clipped convex
#' hulls computed and stored in the \code{geometry} column.
#' @examples
#' data.frame <- makeLandClippedHulls(data.frame)
#' @export
makeLandClippedHulls <- function(x) {
  # transform crs to make st_intersect happy
  x <- st_transform(x, 2163)
  # makes a base for hulls to be clipped to
  landMap <- rnaturalearth::ne_countries(returnclass = 'sf') %>%
    st_union()
  # transform crs to make st_intersect happy
  landMap <- st_transform(landMap, 2163)
  # empty list to rebuild the df from
  output <- c()
  # pre-allocate for slight speed gain
  # df$convex_hull <- NA
  for (var in unique(x$binomial)) {
    # splits data into species groups
    subsetOfDf <- x[x$binomial == var,]
    subsetOfDf$geometry <- st_convex_hull(st_combine(subsetOfDf$geometry))
    # sets to correct (long/lat) crs for comparison
    # subsetOfDf <- st_set_crs(subsetOfDf, 4326)
    clippedHull <- st_intersection(subsetOfDf$geometry, landMap)
    if (purrr::is_empty(clippedHull)) {
      # error handling here
      # this function is ONLY for terrestrial convex hulls
      print('Hull is entirely in the ocean')
    } else {
      subsetOfDf$geometry <- clippedHull
    }
    output <- rbind(output, subsetOfDf)
    output <- st_transform(output, 4326)
  }
  return(output)
}
