#' Creates Convex Hulls
#'
#' \code{makeConvexHulls} returns the computed convex hulls by species for a
#' single object of class sf (a data frame).
#'
#' These hulls are not clipped,
#' for hulls clipped to landmasses, see \link[sfe]{clipHullsToLand},
#' or alternatively see \link[sfe]{makeLandClippedHulls}. \code{x} must have
#' both a \code{geometry} and a \code{binomial} column present to work.
#'
#' For more felxible convex hull generation see \link[sf]{st_convex_hull}
#' @param x object of class sf, sfc or sfg
#' @return Returns object \code{x} with convex hulls computed and stored in the
#' \code{geometry} column.
#' @examples
#' data.frame <- makeConvexHull(data.frame)
#' @export
makeConvexHulls <- function(x) {
  # empty list to rebuild the df from
  output <- c()
  # preallocating for speed gains
  # df$convex_hull <- NA
  for (var in unique(x$binomial)) {
    # breaking down df to species level
    subsetOfDf <- x[x$binomial == var,]
    subsetOfDf$geometry <- st_convex_hull(st_combine(subsetOfDf$geometry))
    # making sure crs is set
    subsetOfDf <- st_set_crs(subsetOfDf, 4326)
    output <- rbind(output, subsetOfDf)
  }
  return(output)
}
