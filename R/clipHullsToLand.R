#' Clips convex hulls to landmasses
#'
#' \code{clipHullsToLand} returns the clipped convex hulls by species for a
#' single object of class sf (a data frame).
#'
#' These hulls are clipped to landmasses only.
#' To generate hulls and clip them to landmasses with a single function see
#' \link[sfe]{makeLandClippedHulls}. \code{x} must have
#' both a \code{geometry} and a \code{binomial} column present to work.
#'
#' For more felxible convex hull generation see \link[sf]{st_convex_hull}
#'
#' Landmasses used to clip to are generated from the \code{rnaturalearth}
#' package using the \code{ne_countries} function. please see its documentation
#' here \link[rnaturalearth]{ne_countries} for a full breakdown.
#' @param x object of class sf, sfc or sfg
#' @return Returns object \code{x} with clipped convex hulls computed and stored
#' in the \code{convex_hull} column.
#' @examples
#' data.frame <- clipHullsToLand(data.frame)
#' @export
clipHullsToLand <- function(x) {
  # making a world map of the land
  landMap <- rnaturalearth::ne_countries(returnclass = 'sf') %>%
    st_union()
  landMap <- st_transform(landMap, 2163)
  # print(st_is_valid(landMap))
  x <- st_transform(x, 2163)
  output <- c()
  for (var in unique(x$binomial)) {
    # print(var)
    # print(str(x))
    #print(st_is_valid(output))
    subsetOfDf <- x[x$binomial == var,]
    clippedHull <-  st_intersection(lwgeom::st_make_valid(subsetOfDf$geometry), lwgeom::st_make_valid(landMap))
    # clippedHull <-  suppressMessages(st_intersection(subsetOfDf$geometry, landMap))
    # ocean <- st_difference(subsetOfDf$convex_hull, landMap)
    if (purrr::is_empty(clippedHull)) {
      # error handling here
      # can make this more complex but currently
      # this is just for working terrestrially
      print('Hull is entirely in the ocean')
    } else {
      # print(clippedHull)
      subsetOfDf$geometry <- clippedHull

    }
    subsetOfDf <- st_transform(subsetOfDf, 4326)
    output <- rbind(output, subsetOfDf)
    output <- st_transform(output, 4326)
  }
  return(output)
}
