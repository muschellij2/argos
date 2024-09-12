#' Install Argos Conda Environment
#'
#' @param envname The name of, or path to, a conda environment.
#' @param packages character vector of packages to install.  ``argostranslate"`
#' is automatically added to the vector, passed to [reticulate::py_install()]
#' @param ... additional arguments to pass to  [reticulate::conda_create()].
#'
#' @return Returns the path to the Python binary associated with the
#' newly-created conda environment.
#' @export
#'
#' @examples
#' \dontrun{
#'   if (!is_argos_installed()) {
#'     create_argos_condaenv()
#'   }
#' }
create_argos_condaenv = function(
    envname = "argos",
    packages = "argostranslate",
    ...) {

  reticulate::conda_create(
    envname = envname,
    packages = packages,
    ...,
  )
}
