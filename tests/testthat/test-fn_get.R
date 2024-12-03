test_that("List of model parameters is retrieved from Dataverse dataset",{
  expect_no_error(parameters_ls <- get_input_data())
  skip_on_cran()
  # expect_true(!is.null(dvs_tb))
  if(!is.null(parameters_ls)){
    expect_true(is.list(parameters_ls))
    expect_true(all(names(parameters_ls) == c("first", "second", "third", "fourth")))
  }
}
)
test_that("Mode parameter values can be retrieved from paramters list",{
  expect_no_error(first_1L_int <- get_parameter_value("first", parameters_ls))
  # expect_true(!is.null(libraries_tb))
  if(!is.null(first_int)){
    expect_true(first_1L_int==5)
  }
}
)
test_that("Repository names retrieved from project GitHub organisation",{
  expect_no_error(repos_chr <- get_project_repos())
  if(!is.null(repos_chr)){
    expect_true("avert" %in% repos_chr)
  }

}
)
