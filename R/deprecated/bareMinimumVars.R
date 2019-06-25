#' Reduces the data frame to minimum variables nedded for analysis
#' Keeps 'binomial', 'TypeStatus' and 'geometry'
#' Allows retention of previous name/ dynamic df naming
#' via terminal input
#' If using on IUCN data set please add TypeStatus Col
#' With the command df$TypeStatus <- 'IUCN'
#' @param df sf data frame
#' @return df named by user, with only the specified cols
#' @export
bareMinimumVars <- function(df) {
  myvars <- c('binomial', 'TypeStatus', 'geometry')
  # df$TypeStatus <- 'IUCN'
  df <- df[myvars]
  dfName <- readline(prompt = 'please enter df name: ')
  assign(dfName,df,envir=.GlobalEnv)
}

