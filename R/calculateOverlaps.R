# two input function for calculating the percentage overlap
calcOverlaps <- function(df1, df2) {
  df1 <- lwgeom::lwgeom_make_valid(df1)
  # adding additional crs transfroms
  # as for some unknown reason it is convinced that CRS do not match at this point
  print("3rd transform")
  df1 <- st_transform(df1, 2163)
  df2 <- st_transform(df2, 2163)
  # gives percentage overlap between NHM and IUCN
  overlap <- st_intersection(df1, df2) %>% st_area() / st_area(df1, df2) * 100
  # at this point the output is of class "units" which don't play nice
  overlap <- units::drop_units(overlap)
  # allows for handling of cases of zero overlap
  if (purrr::is_empty(overlap) == T) {
    # as it otherwise returns a list of length zero,
    # which cannot be appended to a df
    overlap <- c(0)
  }
  # if(is.na(overlap)){
  #   overlap <-c(0)
  # }
  # if (is.null(overlap)) {
  #   overlap <-c(0)
  # }
  overlap <- as.list(overlap)
  # returns the result, so can be passed to another fun
  return(overlap)
}

hullOverFun <- function(df1, df2) {
  # df1 <- as.data.frame(df1)
  # print(colnames(df1))
  #print(str(df1))
  # adds a column of na's
  df1$Percent_overlap <- NA
  # print(df1$Percent_overlap)
  # df1 <- st_as_sf(df1)
  # df1$Percent_overlap <- NULL
  # for each row in first df's geometry col
  #for (row in 1:nrow(df2)) {
        ## repeat transform and sanitization for
    ## df2? as I get Null through trying to do
    ## that lower for some reason
    #geom2 <- df2$geometry[row]
    #geom2 <- st_transform(geom2, 2163)
    ##print("2nd transform")
    ##df2 <- st_transform(df2$geom, 2163)
    #df2$geometry[row] = geom2
    #}
  df2 = st_transform(df2, 2163)
  for (row in 1:nrow(df1)) {
    # extract the geometry
    geom <- df1$geometry[row]
    #geom <- st_set_crs(geom, 2163)
    geom <- st_transform(geom, 2163)
    # use previous fun to calculate overlaps
    # x <- calcOverlaps(geom, df2$geometry)
    x <- calcOverlaps(geom, df2$geometry)
    # and append to the percent overlap col
    # print(row)
    # if (purrr::is_empty(x) == T) {
    #   # as it otherwise returns a list of length zero,
    #   # which cannot be appended to a df
    #   x <- c(0)
    # }
    # if(is.na(x)){
    #   x <-c(0)
    # }
    # if (is.null(x)) {
    #   x <-c(0)
    # }
    # print(x)
    #df1[,"Percent_overlaps"][row] <- x
    df1$Percent_overlap[row] <- x
    # break
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
  # find all entries in both dfs which match var
  for (var in unique(x$binomial)) {
    # print(var)
    IUCN_var <- y[y$binomial == var,]
    NHM_var <- x[x$binomial == var,]
    # ensure planar crs is in use
    NHM_var <- st_transform(NHM_var, 2163)
    IUCN_var <- st_transform(IUCN_var, 2163)
    #print(class(IUCN_var))
    # then pass to the over_function
    tmp <- hullOverFun(NHM_var, IUCN_var)
    # rebuilding the input df with a new col
    output <- rbind(tmp, output)
  }
  output$Percent_overlap <- as.numeric(output$Percent_overlap)
  return(output)
}
