#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  env <- environment()
  callModule(mod_loading_page_server,'loadingPage')
  callModule(mod_navbar_menu_server,'mainMenu')
  #Global reactive variables for Prostar-core
  rv.prostar <- reactiveValues(
    obj = NULL,
    settings = NULL
  )
  
  
  ## definition des variables globales liees a un pipeline
  rv.core <- reactiveValues(
    # current working data from current pipeline
    type = NULL,
    
    ## indice du dataset courant dans la liste ll.process.
    current.indice = 1,
    
    ## liste qui contiendra les noms des différents datasets enregsitres au cours 
    ## de l'execution sdu module. Il est initialisé à Original car dans tous les cas,
    ## on démarre avec un dataset intitule original
    ll.process = c('original'),
    
    # object returned by demode, openmode and convertmode
    #object that is used for modules in pipeline. C'st une instance d'une classe Pipeline
    current.obj = NULL,
    
    tempplot = NULL,
    loadData = NULL
    
  )
  
  callModule(mod_settings_server, "modSettings",dataIn = reactive({dataIn=NULL}))
  callModule(mod_homepage_server, "homepage")
  callModule(mod_release_notes_server, "modReleaseNotes")
  callModule(mod_check_updates_server, "modCheckUpdates")
  
  callModule(mod_bug_report_server, "bugreport")
  callModule(mod_insert_md_server, "links_MD",URL_links)
  callModule(mod_insert_md_server, "FAQ_MD", URL_FAQ)
  
  #Once the server part is loaded, hide the loading page 
  # and show th main content
  shinyjs::hide(id = "loading_page", anim = FALSE)
  shinyjs::show("main_content", anim = TRUE, animType = "fade")
}