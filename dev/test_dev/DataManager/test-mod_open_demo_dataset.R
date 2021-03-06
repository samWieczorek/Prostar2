library(shiny)
library(MultiAssayExperiment)
library(tibble)


options(shiny.fullstacktrace = TRUE)


source(file.path('../../../R/DataManager', 'mod_choose_pipeline.R'), local=TRUE)$value
source(file.path('../../../R', 'mod_infos_dataset.R'), local=TRUE)$value
source(file.path('../../../R', 'mod_format_DT.R'), local=TRUE)$value
source(file.path('../../../R', 'global.R'), local=TRUE)$value
source(file.path('../../../R/DataManager', 'mod_open_demo_dataset.R'), local=TRUE)$value

actionBtnClass <- "btn-primary"

ui <- fluidPage(
  tagList(
    mod_open_demo_dataset_ui('rl')
    #hr(),
   # mod_infos_dataset_ui("infos")
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output, session) {
  
  rv <- reactiveValues(
    demoData = NULL
  )
  
  rv$demoData <- mod_open_demo_dataset_server("rl")
  
  observeEvent(rv$demoData(),{
    print('demo dataset loaded')

    print(rv$demoData()$dataset)
    print(rv$demoData()$pipeline.name)
  })
  
}


shinyApp(ui, server)
