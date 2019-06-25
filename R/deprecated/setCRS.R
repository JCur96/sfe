#' Sets CRS to long/lat projection (4326)
#' @param df sf df of NHM data
#' @return renamed df to mydata
#' @export
setCRS <- function(df) {
  df <- st_as_sf(df, coords = c('Longitude', 'Latitude'), crs = 4326)
  assign('mydata',df,envir=.GlobalEnv)
}


