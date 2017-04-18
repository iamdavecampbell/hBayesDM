#' @noRd
 
.onAttach <- function(libname, pkgname) {
  ver <- utils::packageVersion("hBayesDM")
  packageStartupMessage("\n\nThis is hBayesDM version ", ver, "\n\n")
}

.onLoad <- function(libname, pkgname) {
  modules <- paste0("stan_fit4", names(stanmodels), "_mod")
  print(modules)
  print(class(modules))
  print(attributes(modules[1]))
  for (m in modules) loadModule(m, what = TRUE)
}
