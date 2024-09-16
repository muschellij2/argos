testthat::test_that("Install Argos works", {
  testthat::skip_on_cran()
  argos::install_argos()
  testthat::expect_true(argos::is_argos_installed())
})


skip_if_argos_not_installed = function() {
  testthat::skip_if(!argos::is_argos_installed())
}
testthat::test_that("Translation to Spanish", {
  skip_if_argos_not_installed()
  hello_world = argos::argos_translate("Hello, world!", "en", "es")
  testthat::expect_equal(
    hello_world,
    "¡Hola, mundo!")

  httptest::without_internet({
    hello_world_no_net = argos::argos_translate(
      "Hello, world!", "en", "es")
  })

  testthat::expect_equal(
    hello_world_no_net,
    "¡Hola, mundo!")
})


testthat::test_that("See if Spanish Translate Installed", {
  skip_if_argos_not_installed()
  testthat::expect_true(
    argos::is_language_package_installed(
      code_from = "en",
      code_to = "es")
  )

  testthat::expect_false(
    argos::is_language_package_installed(code_from = "en",
                                         code_to = "blah")
  )
})

