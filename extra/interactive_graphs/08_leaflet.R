library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lat=4.6955641, lng=-74.0587423, popup="BS escuala en Bogota")
m

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lat=4.6955641, lng=-74.0587423, popup="BS escuala en Bogota") %>%
  addProviderTiles(providers$Stamen.Toner)
m


library(maps)
mapStates = map("world", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% 
  addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
