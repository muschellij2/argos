#' Install Language Package
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
#' install_language_package()
install_language_package = function(
    code_from = "en",
    code_to = "es",
    update_package_index = TRUE
) {

  from_code = to_code = NULL
  rm(list = c("from_code", "to_code"))

  argos = reticulate::import("argostranslate", convert = TRUE)
  apackage = argos$package

  run_from_code = code_from
  run_to_code = code_to

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
