% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/versionControl.R
\name{mydata}
\alias{mydata}
\alias{mydata_versions}
\alias{mydata_version_current}
\alias{mydata_del}
\title{Download example data set}
\usage{
mydata(version = NULL, path = NULL)

mydata_versions(local = TRUE, path = NULL)

mydata_version_current(local = TRUE, path = NULL)

mydata_del(version, path = NULL)
}
\arguments{
\item{version}{Version number.  The default will load the most
recent version on your computer or the most recent version known
to the package if you have never downloaded the data before.
With \\code{sfe_del}, specifying \\code{version = NULL} will
delete \\emph{all} data sets.}

\item{path}{Path to store the data at.  If not given,
\\code{datastorr} will use \\code{rappdirs} to find the best place
to put persistent application data on your system.  You can
delete the persistent data at any time by running
\\code{sfe_del(NULL)} (or \\code{sfe_del(NULL, path)} if you
use a different path).}

\item{local}{Logical indicating if local or github versions should
be polled.  With any luck, \\code{local = FALSE} is a superset of
\\code{local = TRUE}.  For \\code{sfe_version_current}, if
\\code{TRUE}, but there are no local versions, then we do check
for the most recent github version.}
}
\description{
Download the example data set from JCur96/sfe
 (\\url{https://github.com/JCur96/sfe/})
}
