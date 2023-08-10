
<!-- README.md is generated from README.Rmd. Please edit that file -->

# translated

The goal of translated is to serve as a minimal demonstration of a
package with multilingual documentation.

## Installation

You can install the development version of translated from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("eliocamp/translated")
```

## Example

The package has just one dummy function, `translate_me()`, which has
documentation in English and Spanish.

``` r
library(translated)
```

Type `?translate_me` in the console for the default (English)
documentation.

Type `es?translate_me` for the Spanish documentation.

## How it works

### R scaffolding

Each function is documented normally with one .Rd per language. The .Rd
for the default language is documented as usual, but the others have
`\alias{function-lang}` and `\keyword{internal}`. The former makes it so
that `lang?function` opens up the correct page (TODO: understand why)
and the latter to hide the translation in the help index.

### Tooling

The idea is to document functions normally using
[roxygen2](https://roxygen2.r-lib.org/index.html) in the default
language and add a translation
[roclet](https://roxygen2.r-lib.org/reference/roclet.html) that handles
everything else.

This roclet would search for a .yaml file for each documented object
which would hold the translated strings. Each section has its own yaml
field with the `original` text, the `translated` text and a
`needs_update` field to indicate if the original string was changed and
the translation needs to be updated. For example:

``` yaml
title:
  original: Title of documentation
  translated: 'Título de la documentación'
  needs_update: no
```

The roclet would then create a new .Rd file for each of these files.

If the yaml file doesn’t exist (e.g. it’s a new function that doesn’t
have any translation), the roclet would create the yaml with empty
`translated` strings.

If the string in the original documentation is different from the string
in the `original` field, then the roclet would update the field and the
`needs_update` field.

# Missing pieces

1.  The translation roclet doesn’t work well and is missing parts.
2.  Documentation pages are not linked to their translations.
3.  Documentation pages don’t have a way of informing if they are
    outdated.
