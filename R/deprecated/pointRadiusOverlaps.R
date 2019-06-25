overlaps <- function(x, y) {
  # gives percentage overlap between NHM and IUCN
  overlap <- st_intersection(x, y) %>% st_area() * 100 / st_area(y)
  # at this point the output is of class "units" which don't play nice
  overlap <- drop_units(overlap)
  # allows for handling of cases of zero overlap
  if (is_empty(overlap) ==T) {
    # as it otherwise returns a list of length zero, which
    # cannot be appended to a df
    overlap <- c(0)
  }
  overlap <- as.list(overlap)
  # returns the result, so can be passed to another fun
  return(overlap)
}
overFun <- function(x, y) {
  # adds a column of na's
  x[,"Percent_overlap"] <- NA
  # for each row in first df's geometry col
  for (row in 1:nrow(x)) {
    # extract the geometry
    geom <- x$geometry[row]
    # use previous fun to calculate overlaps
    x <- overlaps(geom, y$geometry)
    # and append to the percent overlap col
    x$Percent_overlap[row] <- x
  }
  return(x) # return the modified df for use in another fun
}
#' Calculates percent overlap of IUCN range polygons and NHM point-radius data
#'
#' \code{pointRadiusOverlaps} calculates the percentage overlap between the
#' Natural History Museum (NHM) point-radius records and IUCN range polygons.
#'
#' This is a two input function for calculating the percentage overlap between
#' NHM and IUCN datasets, where the NHM data is point-radius only.
#'
#' Data frame order matters for this function, please input NHM first and IUCN
#' second, otherwise you will get odd results!
#'
#' @param x an object of class sf, sfc or sfg containing Natural History Museum
#' records
#' @param y object of class sf, sfc or sfg, containing IUCN range polygon data
#' @return object \code{x}, the NHM data set, with an added percent overlap
#' column, containing calculated percentage overlap between NHM point-radius
#' records and IUCN range polygons
#' @examples
#' NHM_Data <- pointRadiusOverlaps(NHM_Data, IUCN_Data)
#' @export
pointRadiusOverlaps <- function(x, y) {
  # create an empty list to store results
  output <- c()
  # find all entries in both dfs which match var
  for (var in unique(x$binomial)) {
    IUCN_var <- y[y$binomial == var,]
    NHM_var <- x[x$binomial == var,]
    # ensure planar crs is in use
    NHM_var <- st_transform(NHM_var, 2163)
    IUCN_var <- st_transform(IUCN_var, 2163)
    # then pass to the over_function
    out <- over_fun(NHM_var, IUCN_var)
    # rebuilding the input df with a new col
    output <- rbind(out, output)
  }
  # output <<- data.frame(output)
  return(output)
}
