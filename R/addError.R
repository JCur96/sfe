#' Adds error radius to point coordinate data
#'
#' \code{addError} adds an error radius using the point-radius method outlined
#' in this here \link{http://www.herpnet.org/herpnet/documents/wieczorek.pdf}
#' and converts to data to a long/lat CRS.
#' @param x An object of sf, sfc or sfg format, containing a geometry
#' and an Extent_km column
#' @return returns \code{x} with point radius method applied to geometry column,
#' turning longitude/lattitude point data into a polygon of \code{Extent_km}
#' raidus centred on the point data given in \code{geometry}
#' @examples
#' data.frame <- addError(data.frame)
#' @export
addError <- function(x) {
  x <- st_transform(x, '+proj=utm +zone=42N +datum=WGS84 +units=km')
  x <- st_buffer(x, x$Extent_km)
  x <- st_transform(x, 4326)
  return(x)
}

