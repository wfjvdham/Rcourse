library(ggplot2)
library(leaflet)

#* Example of customizing graphical output
#* @png (width = 400, height = 500)
#* @get /plot
function(x = "Sepal.Length", y = "Sepal.Width"){
  x <- sym(x)
  y <- sym(y)
  print(
    ggplot(iris) +
      geom_point(aes(!! as.name(x), !! as.name(y), color = Species))
  )
}

#* @serializer htmlwidget
#* @get /map/<lng:numeric>/<lat:numeric>
function(lng=174.768, lat=-36.852){
  leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=lng, lat=lat, popup="The start of R")
}
