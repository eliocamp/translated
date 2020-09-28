if (FALSE) {
  tag_as_yaml <- function(tag) {
    UseMethod("tag_as_yaml")
  }

  tag_as_yaml.default <- function(tag) {
    list(original = tag$val,
         translated = "",
         needs_update = TRUE)

  }

  tag_as_yaml.roxy_tag_usage <- function(tag) {
    NULL
  }

  tag_as_yaml.roxy_tag_.formals <- function(tag) {
    NULL
  }

  tag_as_yaml.roxy_tag_backref <- function(tag) {
    NULL
  }

  tag_as_yaml.roxy_tag_export <- function(tag) {
    NULL
  }

  to_translate <- lapply(tags, tag_as_yaml)

  to_translate <- setNames(to_translate, vapply(tags, function(x) x$tag, character(1)))

  to_translate <- to_translate[lengths(to_translate) > 0]


  alias <- paste0(b$object$alias, "-es")
  file <- paste0(b$object$alias, "-es.yaml")



  yaml::write_yaml(to_translate, file.path("man_translate",  file))


  translated_yaml <- yaml::read_yaml(file.path("man_translate",  file))


}
