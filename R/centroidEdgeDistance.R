#' Calculates the distance between the centroid of a one convex hull and up to
#' two other hulls
#'
#' \code{centroidEdgeDistance} calculates the distance from the centroid of one
#' convex hull to the edge of up to two other hulls for a given species. This
#' was developed to produce data for further analysis of species range changes
#' from historical records to current estimates.
#'
#' @param x an object of class sf, sfc or sfg containing data from Natural
#' History Museum archives. Contains a \code{binomial} column and geometry.
#' @param y n object of class sf, sfc or sfg containing data from IUCN records.
#' Contains a \code{binomial} column and geometry.
#' @return returns \code{x} now with additional \code{distance} columns, which
#' contain the computed distance between the centroid given in \code{x} and the
#' nearest edge of the centroid(s) given in \code{y}
#' @examples
#' x <- centroidEdgeDistance(x, y)
#' @export
centroidEdgeDistance <- function(x, y) {
  output <- c()
  x$distance <- NA
  x$distance2 <- NA
  for (var in unique(x$binomial)) {
    subsetOfDf <- x[x$binomial == var,]
    subsetOfIUCN <- y[y$binomial == var,]
    subsetOfDf$geometry <- st_transform(subsetOfDf$geometry, 2163)
    subsetOfIUCN <- st_transform(subsetOfIUCN, 2163)
    # finds the centroid (point geom of convex hull)
    centroid <- st_centroid(subsetOfDf$geometry)
    edgeDist <- st_distance(centroid, subsetOfIUCN$geometry)
    edgeDist <- units::drop_units(edgeDist)
    edgeDist <- edgeDist/1000
    # print(edgeDist)
    # allows for handling of cases of zero overlap
    if (purrr::is_empty(edgeDist) == T) {
      # as it otherwise returns a list of length zero, which cannot be appended to a df
      edgeDist <- c(0)
    }
    # print(ncol(edgeDist))
    matrixSize <- ncol(edgeDist)
    if (ncol(edgeDist) == 1) {
      subsetOfDf$distance <- edgeDist
    } else if (ncol(edgeDist) == 2) {
      subsetOfDf$distance <- edgeDist[, 1]
      subsetOfDf$distance2 <- edgeDist[, 2]
    } else {
      print('IUCN data contains more than two polygons, please reduce to areas
            of interest and try again')
    }
    # subsetOfDf$geometry <- st_transform(subsetOfDf$geometry, 4326)
    output <- rbind(output, subsetOfDf)
  }
  return(output)
}
