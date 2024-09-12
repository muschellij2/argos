#' Install Argos Language Package
#'
#' @param code_from Code for the language text is coming from
#' @param code_to Code for the language text is going to
#' @param update_package_index Should package index be updated prior to
#' running install_language
#'
#' @return The `data.frame` of the information of the package installed.
#' @export
#'
#' @examples
#' if (is_argos_installed()) {
#'   install_language_package()
#' }
install_language_package = function(
    code_from = "en",
    code_to = "es",
    update_package_index = TRUE
) {

  from_code = to_code = NULL
  rm(list = c("from_code", "to_code"))

  run_from_code = code_from
  run_to_code = code_to


  argos = reticulate::import("argostranslate", convert = TRUE)
  apackage = argos$package

  if (!curl::has_internet()) {
    warning("No internet detected, install_language_package may not work!")
  }
  if (update_package_index) {
    # Download and install Argos Translate package
    apackage$update_package_index()
  }


  # Get available packages
  available_packages = apackage$get_available_packages()
  # Create a data.frame for packages and the from/to codes with argos
  # package object list
  df_package = vector(mode = "list", length = length(available_packages))
  for (ipackage in seq_along(available_packages)) {
    x = available_packages[[ipackage]]
    names_extract = c("code", "from_code", "to_code",
                      "from_name", "to_name", "type")
    res = sapply(names_extract, function(r) {
      x[[r]]
    })
    df = as.data.frame(as.list(res))
    stopifnot(nrow(df) == 1)
    df$package = as.character(x)
    df
    df_package[[ipackage]] = df
  }

  # turn it into a data.frame and use an indexer
  df_package = dplyr::bind_rows(df_package)
  df_package = df_package %>%
    dplyr::mutate(index = 1:dplyr::n())

  # get the correct package_to_install
  package_to_install = df_package %>%
    dplyr::filter(from_code == run_from_code, to_code == run_to_code)
  package_to_install = available_packages[[package_to_install$index]]
  apackage$install_from_path(package_to_install$download())
  package_to_install
}


#' @rdname install_language_package
#' @export
is_language_package_installed = function(
    code_from = "en",
    code_to = "es"
) {
  from_code = to_code = NULL
  rm(list = c("from_code", "to_code"))

  run_from_code = code_from
  run_to_code = code_to

  df_package = list_installed_language_packages()
  if (NROW(df_package) == 0) {
    return(FALSE)
  }
  package_to_install = df_package %>%
    dplyr::filter(from_code == run_from_code, to_code == run_to_code)
  return(nrow(package_to_install) > 0)
}

#' List Installed Argos Language Packages
#'
#' @return If none installed, `NULL` and if some are installed, a `data.frame`
#' of information of the language packags
#' @export
#'
#' @examples
#' if (is_argos_installed()) {
#'   list_installed_language_packages()
#' }
list_installed_language_packages = function() {
  argos = reticulate::import("argostranslate", convert = TRUE)
  installed_packages =  argos$package$get_installed_packages()
  if (length(installed_packages) == 0) {
    return(NULL)
  }
  # Create a data.frame for packages and the from/to codes with argos
  # package object list
  df_package = vector(mode = "list", length = length(installed_packages))
  for (ipackage in seq_along(installed_packages)) {
    x = installed_packages[[ipackage]]
    names_extract = c("code", "from_code", "to_code",
                      "from_name", "to_name", "type")
    res = lapply(names_extract, function(r) {
      x[[r]]
    })
    res = sapply(res, function(r) {
      if (is.null(r)) {
        r = NA_character_
      }
      r
    })
    df = as.data.frame(as.list(res))
    df$package = as.character(x)
    df
    df_package[[ipackage]] = df
  }

  # turn it into a data.frame and use an indexer
  df_package = dplyr::bind_rows(df_package)
  df_package
}

