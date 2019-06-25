#' Removing NA's and entries with error greater 800km (larger than some countries in South America)
#' @param df sf format df, NHM data
#' @return renamed df 'mydata' without NA entries or overly large extent buffers
#' @export
removeNA <- function(df) {
  df <- df %>% filter(Longitude !=is.na(Longitude)
                      & Locality != '' & Extent_km < 800 & binomial != '')
  assign('mydata',df,envir=.GlobalEnv)
}
