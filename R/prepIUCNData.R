#' Prepares IUCN data for analysis using sf and sfe functions
#'
#' \code{prepIUCNData} Reads in old format geospatial data taking user input.
#' Terminal prompts ask for path to data and layer type, once entered
#' prepIUCNData is read in and reformated to 'sf' format. Spaces in the
#' \code{binomial} column are replaced with \code{_}
#'
#' @param path is the path to IUCN data
#' @return sf format IUCN data, with binomial underscored
#' @examples
#' data.frame <- prepIUCNData()
#' 'please enter path'
#' path/to/your/data
#' 'please enter layer'
#' AMPHIBIANS
#'
#' @export
prepIUCNData <- function(path = NULL) {
  path <- readline(prompt = 'please enter path to IUCN data: ')
  path <- file.path(path)
  name <- readline(prompt = 'please enter the name of the layer, e.g. AMPHIBIANS: ')
  print('This may take some time')
  df <- readOGR(dsn = path, layer = name)
  df <- st_as_sf(df)
  df <- st_transform(df, 4326)
  df$binomial <- gsub(' ', '_', df$binomial)
  return(df)
  # dfName <- readline(prompt = 'please enter your df name: ')
  # assign(dfName,df,envir=.GlobalEnv)
}
