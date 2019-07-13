#' Plots maps of each species in a binomial list
#'
#' \code{plotMaps} plots maps showing both IUCN and Natural History Museum data
#' to a directory specified by the user. The directroy must have been created
#' prior to using this function, otherwise a "no such directory exists" error is
#' thrown.
#'
#' @param x An object of class sf, sfc or sfg containing Natural History Museum
#' records
#' @param y An object of class sf, sfc or sfg containing IUCN records
#' @param path path to destination folder entered as a string. This must have
#' been created before using this function otherwise you will get an error.
#' @return plots in the dir specified by user input
#' @examples
#' plotMaps(x, y)
#' 'Enter path: path/to/dir'
#' @export
plotMaps <- function(x, y, path = NULL) {
  library(ggplot2)
  if (is.null(path)) {
    path <- readline(prompt = 'Enter path: ')
  }
  path <- file.path(path)
  sfbbox <- st_bbox(x)
  bbox <- unname(sfbbox)
  # puts the coords into the order expected down in ggmap coords
  xlim <- c(bbox[1], bbox[3])
  ylim <- c(bbox[2], bbox[4])
  # make a base map to plot against
  baseMap <- st_as_sf(maps::map('world', plot=F, fill=T))
  # print('This will take some time...')
  for (var in unique(x$binomial)) {
    # Sys.sleep(0.1) # for a progress bar
    IUCN_var <- y[y$binomial == var,]
    NHM_var <- x[x$binomial == var,]
    p = ggplot2::ggplot(data = baseMap) +
      ggplot2::geom_sf() +
      geom_sf(mapping = aes(alpha = 0.5, fill='blue'), data = NHM_var, show.legend = F) +
      # adding IUCN maps
      geom_sf(mapping = aes(alpha = 0.1, fill = "red"), data = IUCN_var, show.legend = F) +
      # zooming to correct cords (South America)
      coord_sf(xlim = xlim, ylim = ylim, expand = T)
    #saving map as png
    png(paste(path, var, '.png', sep=''), width=600, height=500, res=120)
    print(p) # printing to png
    # not sending to screen
    dev.off()
  }
}
