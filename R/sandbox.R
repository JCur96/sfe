#' sandbox.R
#' things that are useful for creating
#' a fully beautified and more correct R
#' package are going in here
#' Hadley's suggestions such as having a linter
#' is a good example of what I'm on about
# install.packages("lintr")
# lintr::lint_package('')
#
# install.packages("rmarkdown")
# install.packages('pandoc')
# devtools::use_package('ggplot2')

# it would be exceedingly sensible to just have convex hull calcs just update
# geometry column, which would streamline several downstream functions, and
# reduce data volume
usethis::edit_r_environ()
devtools::install_github("JCur96/sfe")
devtools::install_github('ropenscilabs/datastorr')
# datastorr is not avaliable for R version 3.6.0!
# so I will have to install an older version to check if this works
# and implement testing on it obviosuly
# Should make a note of this in the description file I think
datastorr::mydata_versions()

datastorr::autogenerate('JCur96/sfe', 'read.csv')
#
