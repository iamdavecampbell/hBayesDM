#' @noRd
 
.onAttach <- function(libname, pkgname) {
  ver <- utils::packageVersion("hBayesDM")
  packageStartupMessage("\n\nThis is hBayesDM version ", ver, "\n\n")
}

.onLoad <- function(libname, pkgname) {
  modules <- paste0("stan_fit4", names(stanmodels), "_mod")
  print(modules)
  for (m in modules){
   print(m)
   loadModule(m, what = TRUE)
   }
}
