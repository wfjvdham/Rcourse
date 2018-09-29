#' function for printing hello
#'
#' prints the hello string combined with the user input to the console
#'
#' @param word that is printed after the hello
#'
#' @return string message
#'
#' @examples
#' hello()
#' hello("wim")
#'
#' @export
hello <- function(word = "world") {
  print(paste("Hello,", word))
}
