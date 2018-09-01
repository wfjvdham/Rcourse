library(ggplot2)
library(leaflet)

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Example of customizing graphical output
#* @png (width = 400, height = 500)
#* @get /plot
function(){
  print(
    ggplot(iris) +
    geom_point(aes(Sepal.Length, Sepal.Width, color = Species))
  )
}

#* @serializer htmlwidget
#* @get /map
function(){
  leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The start of R")
}
