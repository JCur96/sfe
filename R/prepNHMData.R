#' Reads a .csv file and converts it to a filtered sf object (a data frame)
#'
#' \code{prepNHMData} Reads in old format geospatial data taking user input.
#' Terminal prompts ask for path to data and layer type, once entered
#' prepIUCNData is read in and reformated to 'sf' format. Spaces in the
#' \code{binomial} column are replaced with \code{_}
#'

#' @param x a csv file containing NHM records
#' @return An object of class sf (a data frame) with a column renamed to
#' \code{binomial}, with binomial names underscorred, filtered to exclude NA
#' values.
#' @examples
#' data.frame <- prepNHMData()
#' 'please enter path'
#' path/to/your/data
#' 'please enter column index to rename'
#' YourIndexHere
#'
#' @export
prepNHMData <- function(x) {
  library(dplyr)
  print(colnames(x))
  colToChange <- readline(prompt = 'please enter column index to rename to binomial: ')
  colToChange <- as.numeric(colToChange)
  colnames(x)[colToChange] <- 'binomial'
  colToChange <- readline(prompt = 'please enter column index to rename to Locality: ')
  colToChange <- as.numeric(colToChange)
  colnames(x)[colToChange] <- 'Locality'
  x <- x %>%
    filter(Longitude != is.na(Longitude)
           & Latitude !=is.na(Latitude) & Locality !='' & binomial != '')
  x$binomial <- gsub(' ', '_', x$binomial)
  x <- st_as_sf(x, coords = c("Longitude", "Latitude"), crs = 4326)
  return(x)
  # dfName <- readline(prompt = 'please enter your df name: ')
  # assign(dfName,df,envir=.GlobalEnv)
}
