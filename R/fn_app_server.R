#' Server Logic for the Avertable Burden App
#'
#' Implements server-side processing for report generation,
#' previewing and export.
#'
#' @param input Shiny input object.
#' @param output Shiny output object.
#' @param session Shiny session object.
#' @param areas_chr Character vector of available geographic areas.
#'
#' @return No return value. Called for side effects.
#'
#' @keywords internal
avert_server <- function(
    input,
    output,
    session,
    areas_chr = make_avert_areas()
) {
  
  report_status <- shiny::reactiveVal("Ready.")
  
  rendered_report <- shiny::reactiveVal(NULL)
  
  report_url <- shiny::reactiveVal(NULL)
  
  rmd_file_reactive <- shiny::reactiveVal(NULL)
  
  effective_output_folder <- shiny::reactive({
    
    if (isTRUE(input$same_output)) {
      
      input$path
      
    } else {
      
      input$output_dir
      
    }
    
  })
  
  template_file <- shiny::reactive({
    
    shiny::req(
      nzchar(input$path)
    )
    
    candidate_files <- list.files(
      path = input$path,
      pattern = "^AvertableBurden\\.Rmd$",
      recursive = TRUE,
      full.names = TRUE
    )
    
    if (length(candidate_files) == 0) {
      
      stop(
        paste(
          "Could not find AvertableBurden.Rmd in:",
          input$path
        )
      )
      
    }
    
    candidate_files[[1]]
    
  })
  
  shiny::observe({
    
    shiny::updateTextInput(
      session,
      "report_name",
      
      value = paste0(
        input$what,
        "_",
        input$when,
        "_",
        format(Sys.time(), "%Y%m%d_%H%M")
      )
    )
    
  })
  
  output$data_folder_status <- shiny::renderText({
    
    if (!nzchar(input$path)) {
      
      return("No data folder specified")
      
    }
    
    if (dir.exists(input$path)) {
      
      "✓ Data folder found"
      
    } else {
      
      "✗ Data folder not found"
      
    }
    
  })
  
  output$output_folder_status <- shiny::renderText({
    
    if (isTRUE(input$same_output)) {
      
      return("✓ Reports will be saved to the data folder")
      
    }
    
    if (!nzchar(input$output_dir)) {
      
      return("No output folder specified")
      
    }
    
    if (dir.exists(input$output_dir)) {
      
      "✓ Output folder found"
      
    } else {
      
      "✗ Output folder not found"
      
    }
    
  })
  
  output$status <- shiny::renderText({
    
    report_status()
    
  })
  
  output$n_regions <- shiny::renderText({
    
    paste(
      length(input$where),
      "geographic area(s) selected"
    )
    
  })
  
  output$parameter_summary <- shiny::renderText({
    
    paste0(
      
      "Statistic: ",
      input$what,
      
      "\nYear: ",
      input$when,
      
      "\nRegions selected: ",
      length(input$where),
      
      "\nAge range: ",
      input$who[1],
      " to ",
      input$who[2],
      
      "\nData folder: ",
      input$path,
      
      "\nOutput folder: ",
      effective_output_folder(),
      
      if (!is.null(rmd_file_reactive())) {
        
        paste0(
          "\nTemplate: ",
          basename(rmd_file_reactive())
        )
        
      } else {
        
        ""
        
      }
      
    )
    
  })
  
  shiny::observeEvent(input$who, {
    
    shiny::updateNumericInput(
      session,
      "age_min",
      value = input$who[1]
    )
    
    shiny::updateNumericInput(
      session,
      "age_max",
      value = input$who[2]
    )
    
  })
  
  shiny::observe({
    
    shiny::req(
      input$age_min,
      input$age_max
    )
    
    if (input$age_min <= input$age_max) {
      
      shiny::updateSliderInput(
        session,
        "who",
        value = c(
          input$age_min,
          input$age_max
        )
      )
      
    }
    
  })
  
  shiny::observeEvent(input$select_all, {
    
    shiny::updateSelectizeInput(
      session,
      "where",
      selected = areas_chr
    )
    
  })
  
  shiny::observeEvent(input$clear_all, {
    
    shiny::updateSelectizeInput(
      session,
      "where",
      selected = character(0)
    )
    
  })
  
  output$report_path <- shiny::renderText({
    
    shiny::req(rendered_report())
    
    rendered_report()
    
  })
  
  output$report_preview <- shiny::renderUI({
    
    shiny::req(report_url())
    
    shiny::tags$iframe(
      
      src = report_url(),
      
      style = paste(
        "width:100%;",
        "height:calc(100vh - 220px);",
        "border:none;"
      )
      
    )
    
  })
  
  shiny::observeEvent(input$open_report, {
    
    shiny::req(report_url())
    
    session$sendCustomMessage(
      "openReport",
      report_url()
    )
    
  })
  
  shiny::observeEvent(input$render_report, {
    
    if (!nzchar(input$path)) {
      
      shiny::showNotification(
        "Please specify a data folder.",
        type = "error"
      )
      
      return()
      
    }
    
    if (!dir.exists(input$path)) {
      
      shiny::showNotification(
        "Data folder does not exist.",
        type = "error"
      )
      
      return()
      
    }
    
    if (!dir.exists(effective_output_folder())) {
      
      shiny::showNotification(
        "Output folder does not exist.",
        type = "error"
      )
      
      return()
      
    }
    
    if (length(input$where) == 0) {
      
      shiny::showNotification(
        "Select at least one geographic area.",
        type = "error"
      )
      
      return()
      
    }
    
    notification <- shiny::showNotification(
      "Rendering report...",
      duration = NULL,
      closeButton = FALSE,
      type = "message"
    )
    
    tryCatch({
      
      rmd_file <- template_file()
      
      rmd_file_reactive(
        rmd_file
      )
      
      resource_prefix <- paste0(
        "reports_",
        as.integer(Sys.time())
      )
      
      rendered_file <- rmarkdown::render(
        
        input = rmd_file,
        
        output_file = paste0(
          input$report_name,
          ".html"
        ),
        
        output_dir = effective_output_folder(),
        
        params = list(
          
          divider = "/",
          
          path = input$path,
          
          what = input$what,
          
          when = input$when,
          
          where = input$where,
          
          who = seq(
            input$who[1],
            input$who[2]
          )
          
        ),
        
        envir = new.env(
          parent = baseenv()
        ),
        
        knit_root_dir = dirname(
          rmd_file
        )
        
      )
      
      shiny::addResourcePath(
        resource_prefix,
        normalizePath(
          effective_output_folder()
        )
      )
      
      report_url(
        
        paste0(
          "/",
          resource_prefix,
          "/",
          basename(rendered_file)
        )
        
      )
      
      rendered_report(
        rendered_file
      )
      
      report_status(
        
        paste(
          "Report rendered successfully:",
          rendered_file
        )
        
      )
      
      shiny::removeNotification(
        notification
      )
      
      shiny::showNotification(
        "Report rendered successfully.",
        type = "message"
      )
      
    },
    error = function(e) {
      
      shiny::removeNotification(
        notification
      )
      
      report_status(
        
        paste(
          "Error:",
          e$message
        )
        
      )
      
      shiny::showNotification(
        e$message,
        type = "error",
        duration = NULL
      )
      
    })
    
  })
  
}