
translate_roclet <- function(lang = "es") {
  roxygen2::roclet("translate", lang = lang)
}

roclet_clean.roclet_translate <- function(x, base_path) {
  roxygen2:::roclet_clean.roclet_rd(x, base_path)
}

roclet_process.roclet_translate <- function(x, blocks, env, base_path) {
  blocks <- lapply(blocks, translate_block)
  topic <- roxygen2:::roclet_process.roclet_rd(x, blocks, env, base_path)
  for (i in seq_along(topic)) {
    topic[[i]]$sections$alias$value <- topic[[i]]$sections$alias$value[-1]
  }

  files <- vapply(blocks, function(b)  paste0(b$object$alias, ".Rd"), character(1))
  setNames(topic, files)
}


translate_block <- function(block, lang = "es") {
  alias <- paste0(block$object$alias, "-es")
  file <- paste0(block$object$alias, "-es.yaml")

  translated_yaml <- yaml::read_yaml(file.path("man_translate",  file))

  translate_tag <- function(tag, translated_yaml) {
    tag$val <- translated_yaml[[tag$tag]]$translated
    tag$raw <- translated_yaml[[tag$tag]]$translated
  }

  for (i in seq_along(block$tags)) {
    name <- block$tags[[i]]$tag
    block$tags[[i]]$val <- translated_yaml[[name]]$translated
    block$tags[[i]]$raw <- translated_yaml[[name]]$translated
  }

  block$object$alias <- alias

  block

}

roclet_output.roclet_translate <- function(x, results, base_path, ...) {
  roxygen2:::roclet_output.roclet_rd(x, results, base_path, is_first = TRUE)
}

# debugonce(roxygen2::roxygenise)


roxygen2::roxygenise(roclets = c("collate", "namespace", "rd", "translate_roclet()"))

