#' Renames the desired column to 'binomial'
#'
#' \code{correctColName} returns the input data frame with whichever column
#' was sepcified in the console renamed to \code{binomial}.
#'
#' Many other functions require a binomial column to work, as they subset by
#' species.
#'
#' @param x object of class sf, sfc or sfg
#' @return An sf data frame with a column renamed as 'binomial'
#' @examples data.frame <- correctColName(data.frame)
#' @export
correctColName <- function(x) {
  # needs usr input, so probably a
  print(colnames(x)) # followed by a
  colToChange <- readline(prompt = 'please enter column index to
                          rename to binomial: ')
  colToChange <- as.numeric(colToChange)
  colnames(x)[colToChange] <- 'binomial'
  return(x)
  # assign('mydata',df,envir=.GlobalEnv) # might want to look at dynamic naming

}
