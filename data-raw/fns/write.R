write_report <- function(consent_1L_chr = "",
                         consent_indcs_int = 1L,
                         markdown_dir_1L_chr = character(0),
                         options_chr = c("Y", "N"),
                         output_dir_1L_chr = character(0)){
  if(identical(markdown_dir_1L_chr, character(0))|identical(output_dir_1L_chr, character(0))){
    temp_dir_1L_chr <- tempdir()
    if(identical(markdown_dir_1L_chr, character(0))){
      markdown_dir_1L_chr <- paste0(temp_dir_1L_chr, "/Markdown")
    }
    if(identical(output_dir_1L_chr, character(0))){
      output_dir_1L_chr <- paste0(temp_dir_1L_chr, "/Output")
    }
  }
  X <- ready4show::Ready4showSynopsis(background_1L_chr = "The data reported in this document is entirely fictional.",
                          coi_1L_chr = "None declared.",
                          conclusion_1L_chr = "These fake results are not to be used to inform decision making.",
                          digits_int = 3L,
                          ethics_1L_chr = "No ethics approval has been received for the work summarised in this report.",
                          funding_1L_chr = "No funding information is available for this report.",
                          interval_chr = NA_character_,
                          keywords_chr = c("entirely","fake","do", "not","cite"),
                          outp_formats_chr = "PDF",
                          sample_desc_1L_chr = NA_character_,
                          title_1L_chr = "A hypothetical report from the avert compuational model")
  X <- renewSlot(X,
                 "authors_r3",
                 first_nm_chr = "FirstName",
                 middle_nm_chr = "",
                 last_nm_chr = "FamilyNAme",
                 title_chr = "Dr",
                 qualifications_chr = "MD, PhD",
                 institute_chr = "Institute_A, Institute_B",
                 sequence_int = 1,
                 is_corresponding_lgl = T,
                 email_chr = "fake_email@fake_institute.com")  
  X <- renewSlot(X,
                 "institutes_r3", short_name_chr = "Institute_A", long_name_chr = "Institute A, Australia") %>%
    renewSlot("institutes_r3", short_name_chr = "Institute_B", long_name_chr = "Institute B, Australia")
  authorData(X,
             consent_1L_chr = consent_1L_chr,
             consent_indcs_int = consent_indcs_int,
             options_chr = options_chr,
             tmpl_url_1L_chr = "https://github.com/avertableburden/avert_report",
             tmpl_version_1L_chr = "0.0.1",
             what_1L_chr = "Manuscript")
  authorReport(X, consent_1L_chr = consent_1L_chr)

}