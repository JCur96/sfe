#' Reads in old format geospatial data from
#' User terminal input
#' Terminal prompts ask for path to data and layer type
#' @param path  Path to data entered as a string, default is \code{NULL}
#'
#' @param name layer for readOGR to work with, entered as a string,  default is
#' \code{NULL}
#'
#' Parameters are enterd into the console where prompted. Both a
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
inReadOld <- function(path = ' ', name = ' ') {
  if (purrr::is_empty(path) == T) {
    path <- readline(prompt = 'please enter path to IUCN data: ')
  }
  path <- file.path(path)
  if (purrr::is_empty(name) == T) {
    name <- readline(prompt = 'please enter the name of the layer, this will be
                  # the name of the shape file without the extension: ')
  } else{
    name <- name
  }
  print('This may take some time')
  df <- readOGR(dsn = path, layer = name)
  assign('IUCNData',df,envir=.GlobalEnv)
}
