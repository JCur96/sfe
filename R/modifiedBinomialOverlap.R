#' Turns percentage overlap data into binomial data at a 50% threshold
#'
#' \code{modifiedBinomialOverlap} turns previously calculated percentage overlap data
#' into binomial (yes/no or 1/0) overlap data on a per species basis. This is in
#' preparation for analysis using binomial GLMM's.
#'
#' You will get a warning messages saying only the first value will be used to
#' check if an \code{if} condition is true, these arise due to R interpreting
#' the column of \code{Percent_overlap} as a list, so can be safely ignored.
#'
#' @param x an object of class sf, sfc or sfg, containing calculated percentage
#' overlaps of range polygons between Natrual History Museum data and IUCN data.
#'
#' @return \code{x} with the \code{Percent_overlaps} column "flattened" to
#' binomial data.
#'
#' @examples
#' x <- binomialOverlap(x)
#' @export
modifiedBinomialOverlap <- function(x) {
  output <- c()
  for (var in unique(x$binomial)) {
    subsetOfDf <- x[x$binomial == var,]
    # subsetOfDf$Percent_overlap <- as.numeric(subsetOfDf$Percent_overlap)
    if ((subsetOfDf$Percent_overlap > 50.99) == T) {
      subsetOfDf$Percent_overlap <- 1
    } else if (subsetOfDf$Percent_overlap <= 50.99) {
      subsetOfDf$Percent_overlap <- 0
    }
    output <- rbind(output, subsetOfDf)
  }
  output$Percent_overlap <- as.integer(output$Percent_overlap)
  names(output)[names(output) == 'Percent_overlap'] <- 'binomial_overlap'
  return(output)
}
