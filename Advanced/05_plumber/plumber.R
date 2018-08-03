library(plumber)

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  paste("The message is:", msg)
}

#' Example of customizing graphical output
#' @png (width = 400, height = 500)
#' @get /
function(){
  plot(1:10)
}

#* @get /htmlwidget 
#* @serializer htmlwidget 
# TODO

# TODO require imputs