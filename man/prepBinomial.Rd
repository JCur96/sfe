% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepBinomial.R
\name{prepBinomial}
\alias{prepBinomial}
\title{Replaces spaces with '_' in a \code{binomial} column}
\usage{
prepBinomial(x)
}
\arguments{
\item{x}{an object of class sf, sfc or sfg with a \code{binomial} column,
which contains spaces (so unreadable to R)}
}
\value{
\code{x} with spaces removed from \code{binomial} column
}
\description{
\code{prepBinomial} removes spaces in a \code{binomial} column to prepare it
for further functions. This needs to be done as \code{R} cannot interpret
character values seperated by spaces as single values.
}
\examples{
x <- prepBinomial(x)
}
