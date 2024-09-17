
<!-- README.md is generated from README.Rmd. Please edit that file -->

# argostranslate

<!-- badges: start -->

[![R-CMD-check](https://github.com/muschellij2/argostranslate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/muschellij2/argostranslate/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `argostranslate` is to wrap the
[`argostranslate`](https://github.com/argosopentech/argos-translate)
Python module.

## Installation

You can install the development version of `argostranslate` like so:

``` r
remotes::install_github("muschellij2/argostranslate")
```

### Installation of `argostranslate` Python Module

To install `argostranslate`, you can either run `install_argos`, which
calls `reticulate::py_install()`, If you already have a `conda`
environment enacted, use `reticulate::py_install` or simply
`install_argos`

``` r
library(argostranslate)
install_argos()
```

Or you can run `create_argos_condaenv()`, which calls
`reticulate::conda_create()` and creates a conda environment for
`argos`, named `argos`.

``` r
create_argos_condaenv()
```

If you use this method, you should run
`reticulate::use_condaenv("argos")` before enabling Python.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(argostranslate)
argos_translate("Hello World!")
#> [1] "¡Hola Mundo!"
```

## License

Argos Translate is dual licensed under either the [MIT
License](https://github.com/muschellij2/argostranslate/blob/master/LICENSE).
