
#' Translate via Argos
#'
#' @param text the text to translate in language `code_from` into `code_to`
#' @inheritParams install_language_package
#' @note This only translates the text, it does not install language packages.
#'
#' @return The text from the translation
#' @export
#' @rdname argos_translate
#'
#' @examples
#' if (is_argos_installed()) {
#'   argos_translate("Hello World")
#' }
#' \dontrun{
#'     if (is_argos_installed()) {
#'         argos_translate_only("Hello World")
#'     }
#' }
argos_translate_only = function(
    text,
    code_from = "en",
    code_to = "es"
) {

  argos = reticulate::import("argostranslate", convert = TRUE)
  # Translate
  translate = argos$translate

  text_translated = translate$translate(
    q = text,
    from_code = code_from,
    to_code = code_to)
  return(text_translated)
}

#' @export
#' @rdname argos_translate
argos_translate =  function(
    text,
    code_from = "en",
    code_to = "es",
    update_package_index = TRUE
) {

  if (!curl::has_internet()) {
    warning("No internet detected, skipping install_language_package")
  } else {
    res = try({
      install_language_package(
        code_from = code_from,
        code_to = code_to,
        update_package_index = update_package_index)
    }, silent = TRUE)
    if (inherits(res, "try-error")) {
      warning("Installing language package may have failed")
    }
  }

  result = argos_translate_only(
    text = text,
    code_from = code_from,
    code_to = code_to
  )
  return(result)
}

