#' Unifies IUCN range records to a single entry for each species
#'
#' \code{resolveIUCNGeom} turns IUCN data which has multiple entries for each
#' species into a single record for each species, so that percentage overlaps
#' can be calculated. Internal boundaries are not resolved to preserve
#' information about range fragmentation.
#'
#' @param x an object of class sf, sfc or sfg containing IUCN records, where
#' each species has multiple entries.
#' @return object \code{output}, the IUCN data set, now with a single entry for
#' each species, where the geometry has been unified but internal boundaries have
#' not been resolved, to retain information about range fragmentation.
#' @examples
#' TestOut <- resolveIUCNGeom(IUCNForPlot)
#' @export
resolveIUCNGeom <- function(x) {
  output <- c()
  stepOut <- data.frame(ncol = 2, nrow = 0)
  colNames <- c('binomial', 'geometry')
  colnames(stepOut) <- colNames
  for (var in unique(x$binomial)) {
    IUCN_var <- x[x$binomial == var,]
    y <- st_union(IUCN_var$geometry)
    #print(y)
    stepOut$binomial <- var
    stepOut$geometry <- y
    output <- rbind(stepOut, output)
  }
  #output <- rbind(stepOut, output)
  # output <- as.data.frame(output)
  return(output)
}
