write_avert_report <- function (results_ls, consent_1L_chr = "", consent_indcs_int = 1L, 
                                markdown_dir_1L_chr = character(0), mkdn_source_dir_1L_chr = NA_character_, 
                                options_chr = c("Y", "N"), output_dir_1L_chr = character(0)) 
{
  if (identical(output_dir_1L_chr, character(0))) {
    output_dir_1L_chr <- tempdir()
  }
  X <- ready4show::Ready4showSynopsis(background_1L_chr = "The data reported in this document is entirely fictional.", 
                                      coi_1L_chr = "None declared.", conclusion_1L_chr = "These fake results are not to be used to inform decision making.", 
                                      digits_int = 3L, ethics_1L_chr = "No ethics approval has been received for the work summarised in this report.", 
                                      funding_1L_chr = "No funding information is available for this report.", 
                                      interval_chr = NA_character_, keywords_chr = c("entirely", 
                                                                                     "fake", "do", "not", "cite"), outp_formats_chr = "PDF", 
                                      sample_desc_1L_chr = NA_character_, title_1L_chr = "A hypothetical report from the avert compuational model")
  X <- renewSlot(X, "authors_r3", first_nm_chr = "Anonymous", 
                 middle_nm_chr = "", last_nm_chr = "Author", title_chr = "", 
                 qualifications_chr = "", institute_chr = "Institute_A", 
                 sequence_int = 1, is_corresponding_lgl = T, email_chr = "fake_email@fake_institute.com")
  X <- renewSlot(X, "institutes_r3", short_name_chr = "Institute_A", 
                 long_name_chr = "Anonymous Institute")
  X <- renewSlot(X, "a_Ready4showPaths@outp_data_dir_1L_chr", 
                 output_dir_1L_chr)
  X <- renewSlot(X, "a_Ready4showPaths@mkdn_source_dir_1L_chr", 
                 mkdn_source_dir_1L_chr)
  authorData(X, consent_1L_chr = consent_1L_chr, consent_indcs_int = consent_indcs_int, 
             options_chr = options_chr, tmpl_url_1L_chr = "https://github.com/avertableburden/avert_report", 
             tmpl_version_1L_chr = "0.1.2", what_1L_chr = "Manuscript")
  authorReport(X, consent_1L_chr = consent_1L_chr, args_ls = list(Y = results_ls))
}