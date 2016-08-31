## packages need to be import
pkg <- c("lubridate", "rhandsontable", "shiny", "miniUI", "rstudioapi")
sapply(pkg, function(x) devtools::use_package(x))

## build documentation
devtools::document()

# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
