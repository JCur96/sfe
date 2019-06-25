#' Finds matching binomials (records) between NHM and IUCN data frames
#'
#' \code{matchBinomial} reduces both data frames to contain only records which
#' both contain. Aims to aid with the speed of subsequent calculations.
#'
#' @param x An object of class sf containing NHM data with binomial column
#' @param y An object of class sf containing IUCN data with binomial column
#' @return \code{x}, an object of class sf of NHM data, filtered to contain
#' records binomial which are also present in the IUCN data set.
#' @return \code{IUCNData} an object of class sf containing IUCN data, filtered
#' to contain binomial records present in NHM data
#' @examples
#' matchBinomial()
#' @export
matchBinomial <- function(x, y) {
  binomList <- df1$binomial
  y <- y %>% filter(binomial %in% binomList)
  x <- x %>% filter(binomial %in% y$binomial)
  return(x)
  # return(y)
  #assign('mydata',df1,envir=.GlobalEnv)
  assign('IUCNData', y, envir=.GlobalEnv)
}

