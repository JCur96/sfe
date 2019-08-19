#' Counts the number of binomial overlaps for each species in a data frame
#'
#' \code{countNumbOverlaps} counts the number of binomial overlaps for each
#' species in a data frame. Creates a new column \code{numberOfOverlaps} with
#' this count data for each species.
#'
#' @param x an object of class sf, sfc or sfg containing collection records,
#' including binomial names and binomial overlaps, which can be calculated using
#' \code{sfe::binomialOverlap()}.
#'
#' @return \code{x} with a new column of binomial overlap counts added.
#'
#' @examples
#' x <- countNumbOverlaps(x)
#'
#' @export
countNumbOverlaps <- function(x) {
  x['numberOfOverlaps'] <- NA
  output <- c()
  for (var in unique(x$binomial)) {
    # print(var)
    subsetOfDf <- x[x$binomial == var,]
    tmp <- (length(which(subsetOfDf$binomial_overlap == 1)))
    subsetOfDf$numberOfOverlaps <- tmp
    output <- rbind(output, subsetOfDf)

  }
  return(output)
}
