#' User Interface for the Avertable Burden App
#'
#' Creates the user interface for the Avertable Burden
#' report-generation application.
#'
#' @param areas_chr Character vector of available geographic areas.
#'
#' @return A Shiny UI object.
#'
#' @keywords internal
avert_ui <- function(areas_chr = make_avert_areas()) {
  
  bslib::page_sidebar(
    
    theme = bslib::bs_theme(
      version = 5,
      bootswatch = "flatly"
    ),
    
    title = "Avertable Burden Report Builder",
    
    shiny::tags$script(
      shiny::HTML(
        "
        Shiny.addCustomMessageHandler(
          'openReport',
          function(url) {
            window.open(url, '_blank');
          }
        );
        "
      )
    ),
    
    sidebar = bslib::sidebar(
      
      shiny::h4("Report Parameters"),
      
      shiny::textInput(
        "path",
        "Data Folder",
        placeholder = "e.g. C:/Data/Burden"
      ),
      
      shiny::textOutput("data_folder_status"),
      
      shiny::hr(),
      
      shiny::checkboxInput(
        "same_output",
        "Save report to data folder",
        value = TRUE
      ),
      
      shiny::conditionalPanel(
        condition = "!input.same_output",
        
        shiny::textInput(
          "output_dir",
          "Report Output Folder",
          value = getwd()
        )
      ),
      
      shiny::textOutput("output_folder_status"),
      
      shiny::hr(),
      
      shiny::textInput(
        "report_name",
        "Report Name",
        value = paste0(
          "TotalAvertableDALYs_",
          "2025_",
          format(Sys.time(), "%Y%m%d_%H%M")
        )
      ),
      
      shiny::selectInput(
        "what",
        "Statistic",
        
        choices = c(
          "TotalAvertableDALYs",
          "DALYsAvertablePerRecipient",
          "DALYsAvertablePerCase"
        ),
        
        selected = "TotalAvertableDALYs"
      ),
      
      shiny::selectInput(
        "when",
        "Calendar Year",
        
        choices = as.character(2021:2025),
        
        selected = "2025"
      ),
      
      shiny::selectizeInput(
        "where",
        "Geographic Areas",
        
        choices = areas_chr,
        
        selected = c(
          "Perth - North East",
          "Perth - North West"
        ),
        
        multiple = TRUE,
        
        options = list(
          placeholder = "Search and select regions...",
          plugins = list("remove_button")
        )
      ),
      
      shiny::fluidRow(
        
        shiny::column(
          6,
          
          shiny::actionButton(
            "select_all",
            "Select All",
            width = "100%",
            class = "btn-outline-secondary"
          )
          
        ),
        
        shiny::column(
          6,
          
          shiny::actionButton(
            "clear_all",
            "Clear All",
            width = "100%",
            class = "btn-outline-secondary"
          )
          
        )
        
      ),
      
      shiny::br(),
      
      shiny::textOutput("n_regions"),
      
      shiny::hr(),
      
      shiny::fluidRow(
        
        shiny::column(
          6,
          
          shiny::numericInput(
            "age_min",
            "Minimum Age",
            value = 18,
            min = 0,
            max = 110
          )
          
        ),
        
        shiny::column(
          6,
          
          shiny::numericInput(
            "age_max",
            "Maximum Age",
            value = 30,
            min = 0,
            max = 110
          )
          
        )
        
      ),
      
      shiny::sliderInput(
        "who",
        "Population Age Range",
        min = 0,
        max = 110,
        value = c(18, 30)
      ),
      
      shiny::hr(),
      
      shiny::actionButton(
        "render_report",
        "Render Report",
        class = "btn-success",
        width = "100%"
      ),
      
      shiny::br(),
      shiny::br(),
      
      shiny::actionButton(
        "open_report",
        "Open Report in New Tab",
        width = "100%"
      )
      
    ),
    
    bslib::card(
      
      bslib::card_header("Status"),
      
      shiny::verbatimTextOutput("status")
      
    ),
    
    shiny::br(),
    
    bslib::card(
      
      bslib::card_header("Output File"),
      
      shiny::verbatimTextOutput("report_path")
      
    ),
    
    shiny::br(),
    
    bslib::card(
      
      bslib::card_header("Current Report Parameters"),
      
      shiny::verbatimTextOutput("parameter_summary")
      
    ),
    
    shiny::br(),
    
    bslib::card(
      
      full_screen = TRUE,
      
      bslib::card_header("Report Preview"),
      
      shinycssloaders::withSpinner(
        
        shiny::uiOutput("report_preview"),
        
        type = 6
        
      )
      
    )
    
  )
  
}