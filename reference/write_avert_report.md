# Write avert report

write_avert_report() is a Write function that writes a file to a
specified local directory. Specifically, this function implements an
algorithm to write avert report. The function is called for its side
effects and does not return a value.

## Usage

``` r
write_avert_report(
  results_ls,
  consent_1L_chr = "",
  consent_indcs_int = 1L,
  markdown_dir_1L_chr = character(0),
  mkdn_source_dir_1L_chr = NA_character_,
  options_chr = c("Y", "N"),
  output_dir_1L_chr = character(0)
)
```

## Arguments

- results_ls:

  Results (a list)

- consent_1L_chr:

  Consent (a character vector of length one), Default: ”

- consent_indcs_int:

  Consent indices (an integer vector), Default: 1

- markdown_dir_1L_chr:

  Markdown directory (a character vector of length one), Default:
  character(0)

- mkdn_source_dir_1L_chr:

  Markdown source directory (a character vector of length one), Default:
  'NA'

- options_chr:

  Options (a character vector), Default: c("Y", "N")

- output_dir_1L_chr:

  Output directory (a character vector of length one), Default:
  character(0)

## Value

No return value, called for side effects.
