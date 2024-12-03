get_input_data <- function(){
  X <- ready4use::Ready4useRepos(dv_nm_1L_chr = "avert",
                                 dv_ds_nm_1L_chr = "https://doi.org/10.7910/DVN/QTJJLZ",
                                 dv_server_1L_chr = "dataverse.harvard.edu")
  parameters_xx <- ingest(X,
                          fls_to_ingest_chr = c("that_ls"),
                          metadata_1L_lgl = F)
  return(parameters_xx)
  
}
get_parameter_value <- function(parameter_1L_chr = "first",
                                parameters_ls = NULL){
  if(is.null(parameters_ls)){
    parameters_ls <- get_input_data()
  }
  assertthat::assert_that(parameter_1L_chr %in% names(parameters_ls), msg = "'parameter_1L_chr' must be one of the names of 'parameters_ls'")
  assertthat::assert_that(is.list(parameters_ls), msg = "'parameters_ls' must be a list")
  parameter_xx <- parameters_ls %>% purrr::pluck(parameter_1L_chr)
  return(parameter_xx)
}
get_project_repos <- function(){
  repos_chr <- ready4::get_gh_repos("avertableburden")
  return(repos_chr)
}


