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

#' Remove Adjacent Numbered Suffixes
#'
#' @description
#' This function identifies and removes adjacent numbered suffixes from a character vector.
#' If any strings in the vector have adjacent numerical suffixes, they are replaced with
#' the base string without the numerical suffix.
#'
#' @param vec A character vector containing strings. The strings may end with numbers.
#'
#' @return A character vector with the same elements as the input, but with adjacent
#'   numbered suffixes removed as described.
#'
#' @export
#'
#' @examples
#' template_fill <- c("item1", "item5", "item2", "item3", "item4", "item", "item100",
#' "product1", "product2", "product3", "product", "product11", "j8j", "j9j")
#' result <- remove_adjacent_numbered_suffixes(template_fill)
#' print(result)
#' # "item", "item", "item", "item", "item", "item", "item100", "product",
#' # "product", "product", "product", "product11", "j8j", "j9j"
remove_adjacent_numbered_suffixes <- function(vec) {
  base_names <- gsub("[[:digit:]]+$", "", vec)
  duplicated_base_names <- unique(base_names[duplicated(base_names)])

  # Loop through each duplicated base name
  for (base_name in duplicated_base_names) {
    indices <- grep(paste0("^", base_name, "[[:digit:]]+$"), vec)
    numbers_at_end <- as.numeric(gsub("^.*?([[:digit:]]+)$", "\\1", vec[indices]))
    continuous_sequence <- numbers_at_end[order(numbers_at_end)]
    adjacent_indices <- c(TRUE, diff(continuous_sequence) == 1)

    # If adjacent numbers are found in a sequence, remove the numbers at the end
    if (any(adjacent_indices)) {
      for (i in seq_along(adjacent_indices)) {
        if (adjacent_indices[i]) {
          vec[indices[i]] <- base_name
        }
      }
    }
  }

  return(vec)
}

#' Replace NULL Values Recursively in a List
#'
#' This function recursively searches through a list or nested list
#' and replaces all NULL values with NA. It also records the path
#' where replacements occurred.
#'
#' @param lst A list or nested list where NULL values should be replaced.
#' @param indices A character vector used for recursive tracking of indices.
#'        This should typically be left at its default value when the function is called.
#'
#' @return A list with NULL values replaced by NA.
#'
#' @examples
#' # Example usage:
#' test_lst <- list(a = 1, b = NULL, c = list(d = 4, e = NULL))
#' replace_null_recursive(test_lst)
#'
#' @export
replace_null_recursive <- function(lst, indices = character(0)) {
  if (is.list(lst)) {
    for (i in seq_along(lst)) {
      # Update indices for current iteration
      current_indices <- c(indices, names(lst)[i])

      if (is.null(lst[[i]])) {
        # If the current element is NULL, replace and record the path
        lst[[i]] <- NA
        path_str <- paste(current_indices, collapse = "$")
      } else {
        # Otherwise, continue the recursion
        lst[[i]] <- replace_null_recursive(lst[[i]], current_indices)
      }
    }
  }
  return(lst)
}
