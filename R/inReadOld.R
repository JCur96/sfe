#' Reads in old format geospatial data from
#' User terminal input
#' Terminal prompts ask for path to data and layer type
#' @param ... Parameters are enterd into the console where prompted. Both a
#' path to an IUCN data set and then the layer to read need to be entered
#'
#' @return 'IUCNData', now in sf format
#' @examples
#' inReadOld()
#' "enter path:"
#' ../Data/IUCN_Data
#' "enter layer:"
#' PANGOLINS
#' @export
inReadOld <- function() {
  path <- readline(prompt = 'please enter path to IUCN data: ')
  path <- file.path(path)
  name <- readline(prompt = 'please enter the name of the layer, e.g. AMPHIBIANS: ')
  print('This may take some time')
  df <- readOGR(dsn = path, layer = name)
  assign('IUCNData',df,envir=.GlobalEnv)
}
