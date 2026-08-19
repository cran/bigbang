## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(bigbang)

## ----create-component---------------------------------------------------------
root <- tempfile("bigbang-vignette-")
source_root <- file.path(root, "sources")
archive_root <- file.path(root, "archives")
destination <- file.path(root, "generated")
dir.create(file.path(source_root, "toycomponent", "R"), recursive = TRUE)
dir.create(archive_root)
dir.create(destination)

writeLines(c(
  "Package: toycomponent",
  "Type: Package",
  "Title: Toy Component",
  "Version: 0.1.0",
  "Authors@R: person('Test', 'Author', email='test@example.org', role=c('aut','cre'))",
  "Description: A disposable component used by the bigbang vignette.",
  "License: MIT"
), file.path(source_root, "toycomponent", "DESCRIPTION"), useBytes = TRUE)
writeLines(
  "export(toy_value)",
  file.path(source_root, "toycomponent", "NAMESPACE"),
  useBytes = TRUE
)
writeLines(
  "toy_value <- function() 'hello from the component'",
  file.path(source_root, "toycomponent", "R", "toy.R"),
  useBytes = TRUE
)

withr::with_dir(source_root, utils::tar(
  file.path(archive_root, "toycomponent_0.1.0.tar.gz"),
  files = "toycomponent", compression = "gzip"
))

## ----generate-metapackage-----------------------------------------------------
result <- create_metapackage(
  name = "toyverse",
  packages = "toycomponent_0.1.0",
  pkg_dir = archive_root,
  dest_dir = destination,
  document = FALSE,
  verbose = FALSE,
  import_deps = character(),
  force_deps = character()
)
result
list.files(result$path)

## ----scan-metapackage---------------------------------------------------------
scan <- scan_bigbang_artifact(result$path)
scan
stopifnot(!scan$vulnerable)

## ----eval = FALSE-------------------------------------------------------------
# system2(file.path(R.home("bin"), "R"), c("CMD", "build", result$path))
# install.packages("toyverse_0.1.0.tar.gz", repos = NULL, type = "source")
# library(toyverse)
# toyverse_install()

## ----cleanup, include = FALSE-------------------------------------------------
unlink(root, recursive = TRUE)

