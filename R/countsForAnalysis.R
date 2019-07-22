#' Counts the number of specimens for each species in a data frame
#'
#' \code{countNumbSpecimens} counts the number of unique specimens for each
#' species in a data frame. Creates a new column \code{numberOfSpecimens} with
#' this count data for each species.
#'
#' @param x an object of class sf, sfc or sfg containing collection records,
#' including binomial names.
#'
#' @return \code{x} with a new column of specimen counts added.
#'
#' @examples
#' x <- countNumbSpecimens(x)
#'
#' @export
countNumbSpecimens <- function(x) {
  NHM_Pangolins['numberOfSpecimens'] <- NA
  output <- c()
  for (var in unique(x$binomial)) {
    subsetOfDf <- x[x$binomial == var,]
    tmp <- (length(subsetOfDf$binomial))
    # print(tmp)
    subsetOfDf$numberOfSpecimens <- tmp
    output <- rbind(output, subsetOfDf)
  }
  return(output)
}

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
  NHM_Pangolins['numberOfOverlaps'] <- NA
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
