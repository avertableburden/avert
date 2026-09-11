# Server Logic for the Avertable Burden App

Implements server-side processing for report generation, previewing and
export.

## Usage

``` r
avert_server(input, output, session, areas_chr = make_avert_areas())
```

## Arguments

- input:

  Shiny input object.

- output:

  Shiny output object.

- session:

  Shiny session object.

- areas_chr:

  Character vector of available geographic areas.

## Value

No return value. Called for side effects.
