#' Data checking: create a info file for data checking.
#'
#' @export
datacheck_createinfo_addin <- function() {
  requireNamespace("shiny", quietly = TRUE)
  requireNamespace("miniUI", quietly = TRUE)

  ## ui
  ui <- miniPage(
    gadgetTitleBar("Create Info text file for data cleaning"),
    miniContentPanel(
      fileInput("data", "File contains data to check", accept = ".csv"),
      textInput("out", "Output"),
      h4(style = "color: #AA7732;", "Label: is the full name of variable"),
      h4(style = "color: #AA7732;", "Type: is one of 04 variable types (numeric, character, datetime, factor)"),
      h4(style = "color: #AA7732;", "Unit: is the unit of variable, only applicable for numeric variables"),
      h4(style = "color: #AA7732;", "Value: range of numeric variable (min;max), or format of datetime (ymd_hms), or factor values (1='Male';2='Female')"),
      h4(style = "color: #AA7732;", "Levels: factor levels (Male;Female)"),
      rHandsontableOutput("hot")
    )
  )

  ## server
  server <- function(input, output, session) {
    values <- reactiveValues()

    observe({
      data_input <- input$data
      if (is.null(data_input))
        return(errorMessage("data", "No dataset available."))

      data <- read.csv(data_input$datapath, stringsAsFactors = FALSE)

      ## create info object
      DF <- cbind(varname = names(data),
                  label = "",
                  type = "",
                  unit = "",
                  value = "",
                  levels = "",
                  missing = ""
      )

      if (!is.null(input$hot)) {
        DF <- hot_to_r(input$hot)
      } else {
        if (is.null(values[["DF"]]))
          DF <- DF
        else
          DF <- values[["DF"]]
      }
      values[["DF"]] <- DF
    })

    output$hot <- renderRHandsontable({
      DF <- values[["DF"]]

      if (!is.null(DF))
        rhandsontable(DF, stretchH = "all")
    })

    ## done
    observeEvent(input$done, {
      finalDF <- isolate(values[["DF"]])
      write.csv(finalDF, file = sprintf("%s.csv", input$out), row.names = FALSE)
      invisible(stopApp())
    })

  }

  ## viewer
  viewer <- dialogViewer("Create Info file for data cleaning", width = 1000, height = 800)

  ## run
  runGadget(ui, server, viewer = viewer)
}
