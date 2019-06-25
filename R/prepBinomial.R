#' Replaces spaces with '_' in a \code{binomial} column
#'
#' \code{prepBinomial} removes spaces in a \code{binomial} column to prepare it
#' for further functions. This needs to be done as \code{R} cannot interpret
#' character values seperated by spaces as single values.
#'
#' @param x an object of class sf, sfc or sfg with a \code{binomial} column,
#' which contains spaces (so unreadable to R)
#' @return \code{x} with spaces removed from \code{binomial} column
#' @examples
#' x <- prepBinomial(x)
#' @export
prepBinomial <- function(x) {
  x$binomial <- gsub(' ', '_', x$binomial)
  return(x)
  # dfName <- readline(prompt = 'please enter your df name: ')
  # assign(dfName,df,envir=.GlobalEnv)
}
