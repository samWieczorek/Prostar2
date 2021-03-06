library(shiny)
library(shinyBS)
library(shinyjqui)
library(highcharter)
library(DAPAR2)
library(DT)
library(shinyjs)

source(file.path("../../R", "/mod_bsmodal.R"), local=TRUE)$value
source(file.path("../../R", "global.R"), local = TRUE)$value
source(file.path("../../R", "mod_format_DT.R"), local = TRUE)$value
source(file.path("../../R", "mod_settings.R"), local = TRUE)$value
source(file.path("../../R", "mod_popover_for_help.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_legend_colored_exprs.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_tracking.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_intensity.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_corr_matrix.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_heatmap.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_group_mv.R"),  local = TRUE)$value
source(file.path("../../R", "mod_plots_msnset_explorer.R"),  local = TRUE)$value
source(file.path("../../R", "mod_plots_var_dist.R"), local = TRUE)$value
source(file.path("../../R", "mod_plots_pca.R"), local = TRUE)$value
source(file.path("../../R", "mod_all_plots.R"), local=TRUE)$value

#### test modal ####
ui <- fluidPage(
  absolutePanel(
    mod_bsmodal_ui('exemple')
  ))

server <- function(input, output, session) {
  
  # dans body de modal
  r <- reactiveValues(
    settings = NULL
  )
  
 
  datasets <- utils::data(package="DAPARdata2")$results[,"Item"]
  data('Exp1_R25_pept')
  data('Exp1_R25_prot')
  r$settings <- callModule(mod_settings_server, "settings", obj=reactive({Exp1_R25_prot}))
  
  obj <- Exp1_R25_pept
  samples <- Biobase::pData(obj)
  mae <- PipelineProtein(analysis= 'test',
                         pipelineType = 'peptide', 
                         dataType = 'peptide',
                         processes='original',
                         experiments=list(original=Exp1_R25_prot,
                                          test = Exp1_R25_pept),
                         colData=samples)
  
  callModule(mod_all_plots_server,'exemple_plot',
             dataIn = reactive({mae}),
             settings = reactive({r$settings()}) ) 
  
  
  
  mod_UI <- mod_all_plots_ui('exemple_plot')
  title <- "Plots"
  
  # module d'affichage modal contenant ci-dessus
  callModule(mod_bsmodal_server,'exemple',
             title = title,
             mod_UI = mod_UI,
             width="95%" # en px ou % de largeur
  )
}


shinyApp(ui=ui, server=server)
