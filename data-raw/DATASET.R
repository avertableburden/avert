library(ready4)
library(ready4use)
library(ready4fun)
# MANUAL STEP. Write all your functions to R files in the new "fns" directory.
x <- ready4fun::make_pkg_desc_ls(pkg_title_1L_chr = "Predict The Avertable Burden Attributable To Mental Disorders",
                                 pkg_desc_1L_chr = "An empty shell of an in development library for predicting the burden due to mental disorders that is theoretically avertable with existing healthcare interventions. 
                            This library is being developed with the ready4 framework (https://ready4-dev.github.io/ready4/).
                            This software has been made publicly available as part of the process of testing and documenting the library.
                            For further information email matthew.hamilton2@monash.edu.",
                                 authors_prsn = c(utils::person(given = "Matthew",family = "Hamilton",email = "matthew.hamilton2@monash.edu", role = c("aut", "cre"), comment = c(ORCID = "0000-0001-7407-9194")),
                                                  utils::person("CopyrightHolder", role = c("cph") # If no copyright holder is to be specified, leave as is. Otherwise update these details.
                                                                )
                                 ),
                                 urls_chr = c("https://avertableburden.github.io/avert/",
                                              "https://github.com/avertableburden/avert",
                                              "https://ready4-dev.github.io/ready4/")) %>%
  ready4fun::make_manifest(addl_pkgs_ls = ready4fun::make_addl_pkgs_ls(suggests_chr = c("knitr","knitrBootstrap","rmarkdown"),
                                                                       imports_chr = c("ready4use"),
                                                                       depends_chr = c("ready4")
  ),
  build_ignore_ls = ready4fun::make_build_ignore_ls(file_nms_chr = c("initial_setup.R")),
  check_type_1L_chr = "ready4",
  copyright_holders_chr = "CopyrightHolder", # If no copyright holder is to be specified, leave as is. Otherwise update these details.
  custom_dmt_ls = ready4fun::make_custom_dmt_ls(user_manual_fns_chr = c("get_input_data",
                                                                        "get_parameter_value",
                                                                        "get_project_repos",
                                                                        "write_avert_report"
                                                                        #,
                                                                        # all other functions that you plan to include in the main manual are named here.

                                                                        )),##
  dev_pkgs_chr = c("ready4use"), # Name any development packages imported / suggested / depended on
  lifecycle_stage_1L_chr = "experimental",
  path_to_pkg_logo_1L_chr = "data-raw/logo/default.png",
  piggyback_to_1L_chr = "avertableburden/avert", # Modelling project GitHub organisation # ready4-dev/ready4
  ready4_type_1L_chr = "modelling",
  zenodo_badge_1L_chr = "[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14279520.svg)](https://doi.org/10.5281/zenodo.14279520"#
  )
y <- ready4class::ready4class_constructor()
z <- ready4pack::make_pt_ready4pack_manifest(x,
                                             constructor_r3 = y) %>%
  ready4pack::ready4pack_manifest()
z <- ready4::author(z)
#ready4::write_extra_pkgs_to_actions(path_to_dir_1L_chr = ".github/workflows", consent_1L_chr = "Y")
ready4::write_to_edit_workflow("pkgdown.yaml", consent_1L_chr = "Y") # In other packages, run for "test-coverage.yaml" as well.
# ready4::write_to_edit_workflow("test-coverage.yaml", consent_1L_chr = "Y") # In other packages, run for "test-coverage.yaml" as well.
readLines("README.md") %>% # update in ready4fun
  stringr::str_replace("https://app.codecov","https://codecov") %>% # port edit to ready4fun
  writeLines(con = "README.md")
write_to_tidy_pkg(z$x_ready4fun_manifest,
                  build_vignettes_1L_lgl = TRUE,
                  clean_license_1L_lgl = TRUE,
                  consent_1L_chr = "Y",
                  examples_chr = character(0),
                  project_1L_chr = "Framework",
                  suggest_chr = "pkgload")
# readLines("_pkgdown.yml") %>%
#   stringr::str_replace_all("  - text: Model", "  - text: Framework & Model") %>%
#   writeLines(con = "_pkgdown.yml")
write_citation_fl(z$x_ready4fun_manifest)
desc_chr <- readLines("DESCRIPTION")
# ready4::write_citation_cff(z$x_ready4fun_manifest$initial_ls$pkg_desc_ls %>% append(list(Version = desc_chr[desc_chr %>% startsWith("Version")] %>% stringr::str_remove("Version: "))),
#                            citation_chr = readLines("inst/CITATION"),
#                            publisher_1L_chr = "")
index_1L_int <- which(desc_chr=="    person(\"CopyrightHolder\", role = \"cph\")")
if(!identical(index_1L_int, integer(0))){
  c(desc_chr[1:(index_1L_int-2)], stringr::str_sub(desc_chr[(index_1L_int-1)], end = -2), desc_chr[(index_1L_int+1):length(desc_chr)]) %>%
    writeLines("DESCRIPTION")
  devtools::document()
}
#
