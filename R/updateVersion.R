#' Updates the version number of uploaded data via console input
#'
#' \code{updateVersion} updates the version number (GitHub release) via user
#' input. The console will ask that the user specify a new version number, which
#' will be refelcted in the DESCRIPTION file. This removes the need to hunt for
#' the DESCRIPTION FILE and manually open/edit/save/close it before committing
#' a newly edited data set.
#'
#' @return Updated DESCRIPTION file for easy versionning
#' @examples
#' updateVersion()
#' 'please enter new version number:'
#' Your.New.Version.Number
#' @export
updateVersion <- function() {
  # gets new version number
  verNum <- readline(prompt = 'please enter new version number: ')
  # Makes the line whole again
  verNum = paste('Version:', verNum)
  # reads the lines of file
  lines <- readLines('DESCRIPTION')
  # replaces with updated Ver
  lines[4] <- sub('Version: .+', verNum, lines[4])
  # save lines as DESCRITPTION overwritting it
  Desc <- file('DESCRIPTION')
  writeLines(lines, Desc)
  close(Desc)
  print('IMPORTANT!
  Please make note of whether the version update is due to changes to
        data or because of updates made to the code in the package in your
        commit message'/n/n/n)

}
