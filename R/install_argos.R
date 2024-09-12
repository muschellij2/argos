#' Install Argos
#'
#' @param packages character vector of packages to install.  ``argostranslate"`
#' is automatically added to the vector, passed to [reticulate::py_install()]
#' @param pip Boolean; use pip for package installation?
#' Passed to [reticulate::py_install()]
#' @param ... additional arguments to pass to  [reticulate::py_install()].
#'
#' @return Nothing (`invisible(NULL)`).  Command is called for side effects
#' @export
#'
#' @examples
#' \dontrun{
#'   if (!is_argos_installed()) {
#'     install_argos()
#'   }
#' }
install_argos = function(
    packages = NULL,
    pip = TRUE,
    ...) {
  packages = unique(c(packages, "argostranslate"))
  reticulate::py_install(
    packages = packages,
    pip = pip,
    ...
  )
}

#' @export
#' @rdname install_argos
is_argos_installed = function() {
  reticulate::py_module_available("argostranslate")
}


