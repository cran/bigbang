## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----eval = FALSE-------------------------------------------------------------
# resultado <- create_metapackage(
#   name = "equipoverse",
#   packages = c("datos_1.2.0", "reportes_0.9.1"),
#   pkg_dir = "ruta/a/instalables",
#   ext = ".tar.gz",
#   dest_dir = tempdir(),
#   document = TRUE
# )
# resultado

## ----eval = FALSE-------------------------------------------------------------
# library(equipoverse)
# equipoverse_install(cran_deps = "skip")

## ----eval = FALSE-------------------------------------------------------------
# scan_bigbang_artifact("ruta/al/artefacto", dry_run = TRUE)

