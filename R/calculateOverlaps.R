# two input function for calculating the percentage overlap
overlaps <- function(df1, df2) {
  # gives percentage overlap between NHM and IUCN
  overlap <- st_intersection(df1, df2) %>% st_area() * 100 / st_area(df2)
  # at this point the output is of class "units" which don't play nice
  overlap <- units::drop_units(overlap)
  # allows for handling of cases of zero overlap
  if (purrr::is_empty(overlap) ==T) {
    # as it otherwise returns a list of length zero,
    # which cannot be appended to a df
    overlap <- c(0)
  }
  overlap <- as.list(overlap)
  # returns the result, so can be passed to another fun
  return(overlap)
}

hullOverFun <- function(df1, df2) {
  # for each row in first df's geometry col
  for (row in 1:nrow(df1)) {
    # extract the geometry
    geom <- df1$geometry[row]
    #geom <- st_set_crs(geom, 2163)
    # geom <- st_transform(geom, 2163)
    # use previous fun to calculate overlaps
    x <- overlaps(geom, df2$geometry)
    # and append to the percent overlap col
    df1$Percent_overlap[row] <- x
  }
  return(df1) # return the modified df for use in another fun
}
#' Calculates percent overlap of IUCN and NHM polygons
#'
#' \code{calculateOverlaps} calculates the percentage overlap between the
#' Natural History Museum (NHM) and IUCN range polygons.
#'
#' This is a two input function for calculating the percentage overlap between
#' NHM and IUCN datasets, where both are polygons.
#'
#' @param x an object of class sf, sfc or sfg containing Natural History Museum
#' records
#' @param y object of class sf, sfc or sfg, containing IUCN range polygon data
#' @return object \code{x}, the NHM data set, with an added percent overlap
#' column, containing calculated percentage overlap between NHM and
#' IUCN range polygons
#' @examples
#' NHM_Data <- hullOverlaps(NHM_Data, IUCN_Data)
#' @export
calculateOverlaps <- function(x, y) {
  # create an empty list to store results
  output <- c()
  # adds a column of na's
  x[,"Percent_overlap"] <- NA
  # find all entries in both dfs which match var
  for (var in unique(x$binomial)) {
    IUCN_var <- y[y$binomial == var,]
    NHM_var <- x[x$binomial == var,]
    # ensure planar crs is in use
    # NHM_var <- st_transform(NHM_var, 2163)
    # IUCN_var <- st_transform(IUCN_var, 2163)
    # then pass to the over_function
    x <- hullOverFun(NHM_var, IUCN_var)
    # rebuilding the input df with a new col
    output <- rbind(x, output)
  }
  return(output)
}
