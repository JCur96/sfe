#' Generates world map using the maps package
#' And converts it to sf format
#' @return 'baseMap' is a basic map of the world in sf format
#' @export
makeMap <- function() {
  baseMap <- st_as_sf(map('world', plot=F, fill=T))
  assign('baseMap',baseMap,envir=.GlobalEnv)
  # return(baseMap)
}

