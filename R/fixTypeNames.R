#' Cleans TypeStatus column so that variants of TypeStatus are unified.
#'
#' Uses regex to replace type denotations with the prefix only, unless the
#' denotation is type (or variant), in which case it replaces the variants with
#' \code{type}
#'
#' \code{fixTypeNames} corrects variants of type description (e.g. Type, Types,
#' type, etc.) and turns them into a single description.
#'
#' @param x an object of class sf, sfc or sfg containing a \code{TypeStatus}
#' column.
#' @return an object of class sf, sfc or sfg containing a unified TypeStatus
#' column
#' @examples
#' data.frame <- fixTypeNames(data.frame)
#' @export
fixTypeNames <- function(x) {
  x$TypeStatus <- gsub('syn(.*)', 'syn-', ignore.case = T, x$TypeStatus)
  x$TypeStatus <- gsub('co(.*)', 'co-', ignore.case = T, x$TypeStatus)
  x$TypeStatus <- gsub('para(.*)', 'para-', ignore.case = T, x$TypeStatus)
  x$TypeStatus <- gsub('holo(.*)', 'holo-', ignore.case = T, x$TypeStatus)
  x$TypeStatus <- gsub('type(.*)', 'type', ignore.case = T, x$TypeStatus)
  return(x)
}
