## from: https://github.com/rstudio/addinexamples/blob/master/R/utils.R
stableColumnLayout <- function(...) {
  dots <- list(...)
  n <- length(dots)
  width <- 12 / n
  class <- sprintf("col-xs-%s col-md-%s", width, width)
  fluidRow(
    lapply(dots, function(el) {
      div(class = class, el)
    })
  )
}

isErrorMessage <- function(object) {
  inherits(object, "error_message")
}

errorMessage <- function(type, message) {
  structure(
    list(type = type, message = message),
    class = "error_message"
  )
}

rCodeContainer <- function(...) {
  code <- HTML(as.character(tags$code(class = "language-r", ...)))
  div(pre(code))
}

## from: https://stat.ethz.ch/pipermail/r-help/2007-June/133564.html
file.choose2 <- function(...) {
  pathname <- NULL;
  tryCatch({
    pathname <- file.choose();
  }, error = function(ex) {
  })
  pathname;
}
