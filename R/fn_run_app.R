#' Launch the Avertable Burden App
#'
#' Starts the Avertable Burden Shiny application.
#'
#' @param launch_browser Logical indicating whether the app should
#' automatically open in a browser.
#'
#' @return Invisibly returns the launched application.
#'
#' @examples
#' \dontrun{
#' run_avert_app()
#' }
#'
#' @export
run_avert_app <- function(
    launch_browser = TRUE
) {
  
  required_pkgs <- c(
    "ready4",
    "replica",
    "DT",
    "magrittr",
    "rmarkdown"
  )
  
  missing_pkgs <- required_pkgs[
    !vapply(
      required_pkgs,
      requireNamespace,
      logical(1),
      quietly = TRUE
    )
  ]
  
  if (length(missing_pkgs)) {
    
    stop(
      "Missing required packages: ",
      paste(missing_pkgs, collapse = ", ")
    )
    
  }
  
  shiny::runApp(
    shiny::shinyApp(
      ui = avert_ui(),
      server = avert_server
    ),
    launch.browser = launch_browser
  )
  
}