#' Validate Json-ld
#'
#' @param json_file Json-ld created from the fairify_data function
#'
#' @return Returns a prompt that says whether or not a json-ld is valid
#' @export
#'
#' @examples
#' test_pass <- '{
#' "@context": "http://schema.org/",
#' "@type": "Person",
#' "name": "Jane Doe",
#' "jobTitle": "Professor",
#' "telephone": "(425) 123-4567",
#' "url": "http://www.janedoe.com"}'
#'
#' #validate_jsonld(test_pass)
validate_jsonld <- function(json_file) {

  # If there is an error, return an empty string
  # NOTE Some erroneous json files do not result in an error, but do create an empty string
  validation_string <- tryCatch({
    validation_string <- jsonld::jsonld_to_rdf(json_file)
  },
  error = function(err) {
    return("")
  })

  # Knowing that any errors will result in a character string of 0, we can make an if statement

  if (nchar(validation_string) > 0) {

    # Prompt the user that they have a valid json-ld
    svDialogs::dlg_message("This is a valid json-ld.")

  } else {

    # Prompt the user that they do not have a valid json-ld
    svDialogs::dlg_message("This is not a valid json-ld.")
  }

}

#' Expand Json Files
#'
#' @param json_file Json-ld created from the fairify_data function
#'
#' @return Expanded json-ld file
#' @export
#'
#' @examples
#' json_file <- '{
#' "@context": "http://schema.org/",
#' "@type": "Person",
#' "name": "Jane Doe",
#' "jobTitle": "Professor",
#' "telephone": "(425) 123-4567",
#' "url": "http://www.janedoe.com"}'
#'
#' fair_expand(json_file)
fair_expand <- function(json_file) {

  return(jsonld::jsonld_expand(json_file))
}


#' Plot an igraph visualization of a JSON document
#'
#' @param .x a JSON string or tbl_json object
#' @param legend add a type color legend automatically
#' @param vertex.size the size of the vertices
#' @param edge.color the color for the edges
#' @param edge.width the width of the edge lines
#' @param show.labels should object names be shown
#' @param plot should the plot be rendered?
#' @param ... further arguments to igraph::plot.igraph
#'
#' @importFrom dplyr %>%
#' @return Graph visualization of a json-ld
#' @export
#'
#' @examples
#'json_file <- '{
#' "@context": "http://schema.org/",
#' "@type": "Person",
#' "name": "Jane Doe",
#' "jobTitle": "Professor",
#' "telephone": "(425) 123-4567",
#' "url": "http://www.janedoe.com"}'
#'
#' plot_json_graph(json_file)
plot_json_graph <- function(.x, legend = TRUE, vertex.size = 6,
                            edge.color = 'grey70', edge.width = .5,
                            show.labels = TRUE, plot = TRUE,
                            ...) {
  # Add this to make the R package compilable
  parent.id <- NA
  child.id <- NA
  type <- NA
  name <- NA
  .x <- as.character(.x)

  if (!tidyjson::is.tbl_json(.x)) .x <- tidyjson::as.tbl_json(.x)

  if (nrow(.x) != 1) stop("nrow(.x) not equal to 1")

  structure <- .x %>% tidyjson::json_structure()

  type_colors <- RColorBrewer::brewer.pal(6, "Accent")

  graph_edges <- structure %>%
    dplyr::filter(!is.na(parent.id)) %>%
    dplyr::select(parent.id, child.id)

  graph_vertices <- structure %>%
    dplyr::transmute(child.id,
              vertex.color = type_colors[as.integer(type)],
              vertex.label = name)

  if (!show.labels)
    graph_vertices$vertex.label <- rep(NA_character_, nrow(graph_vertices))

  g <- igraph::graph_from_data_frame(graph_edges, vertices = graph_vertices,
                                     directed = FALSE)

  if (plot) {
    op <- graphics::par(mar = c(0, 0, 0, 0))
    plt <- igraph::plot.igraph(g,
                               vertex.color = igraph::V(g)$vertex.color,
                               vertex.size  = vertex.size,
                               vertex.label = igraph::V(g)$vertex.label,
                               vertex.frame.color = NA,
                               #layout = layout_with_kk,
                               edge.color = edge.color,
                               edge.width = edge.width,
                               ...)

    if (legend)
      legend(x = -1.3, y = -.6, levels(structure$type), pch = 21,
             col= "white", pt.bg = type_colors,
             pt.cex = 2, cex = .8, bty = "n", ncol = 1)

    graphics::par(op)
  }

  invisible(g)

}
