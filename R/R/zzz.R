#' @noRd

.onAttach <- function(libname, pkgname) {
  ver <- utils::packageVersion("hBayesDM")
  packageStartupMessage("\n\nThis is hBayesDM version ", ver, "\n\n")
}

.onLoad <- function(libname, pkgname) {
<<<<<<< HEAD:R/zzz.R
  modules <- paste0("stan_fit4", names(stanmodels), "_mod")
  print(modules)
  for (m in modules){
   print(m)
   loadModule(m, what = TRUE)
   }
}
=======
  # nocov start
  if (FLAG_BUILD_ALL) {
    modules <- paste0("stan_fit4", names(stanmodels), "_mod")
    for (m in modules) loadModule(m, what = TRUE)
  }
} # nocov end

>>>>>>> 44eacacb11016842781e665072c3e52a7e34a93e:R/R/zzz.R
