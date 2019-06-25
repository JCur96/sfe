#' Converts old format geospatial data to new sf format
#' @param df old format geospatial data (IUCN is in this format)
#' @return 'IUCNData' reformatted to sf
#' @export
oldAsNew <- function(df) {
  df <- st_as_sf(df)
  df <- st_transform(df, 4326)
  assign('IUCNData',df,envir=.GlobalEnv)
}

