#' Get input data
#' @description get_input_data() is a Get function that extracts data from an object. Specifically, this function implements an algorithm to get input data. The function returns Parameters (an output object of multiple potential types).

#' @return Parameters (an output object of multiple potential types)
#' @rdname get_input_data
#' @export 
#' @importFrom ready4use Ready4useRepos
get_input_data <- function () 
{
    X <- ready4use::Ready4useRepos(dv_nm_1L_chr = "avert", dv_ds_nm_1L_chr = "https://doi.org/10.7910/DVN/QTJJLZ", 
        dv_server_1L_chr = "dataverse.harvard.edu")
    parameters_xx <- ingest(X, fls_to_ingest_chr = c("that_ls"), 
        metadata_1L_lgl = F)
    return(parameters_xx)
}
#' Get parameter value
#' @description get_parameter_value() is a Get function that extracts data from an object. Specifically, this function implements an algorithm to get parameter value. The function returns Parameter (an output object of multiple potential types).
#' @param parameter_1L_chr Parameter (a character vector of length one), Default: 'first'
#' @param parameters_ls Parameters (a list), Default: NULL
#' @return Parameter (an output object of multiple potential types)
#' @rdname get_parameter_value
#' @export 
#' @importFrom assertthat assert_that
#' @importFrom purrr pluck
get_parameter_value <- function (parameter_1L_chr = "first", parameters_ls = NULL) 
{
    if (is.null(parameters_ls)) {
        parameters_ls <- get_input_data()
    }
    assertthat::assert_that(parameter_1L_chr %in% names(parameters_ls), 
        msg = "'parameter_1L_chr' must be one of the names of 'parameters_ls'")
    assertthat::assert_that(is.list(parameters_ls), msg = "'parameters_ls' must be a list")
    parameter_xx <- parameters_ls %>% purrr::pluck(parameter_1L_chr)
    return(parameter_xx)
}
#' Get project repositories
#' @description get_project_repos() is a Get function that extracts data from an object. Specifically, this function implements an algorithm to get project repositories. The function returns Repositories (a character vector).

#' @return Repositories (a character vector)
#' @rdname get_project_repos
#' @export 
#' @importFrom ready4 get_gh_repos
get_project_repos <- function () 
{
    repos_chr <- ready4::get_gh_repos("avertableburden")
    return(repos_chr)
}
