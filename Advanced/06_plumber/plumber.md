

Plumber
========================================================
author: Wim van der Ham
date: 2018-09-01
autosize: true

What is an API?
========================================================

Computer friendly website

- Serves a computer friendly file format (json)
- Can be called from many languages, platforms and browsers

  - [`httr`](https://github.com/r-lib/httr) package for accesing API's from R
  
Example Endpoint
========================================================


```r
#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = ""){
  list(msg = paste0("The message is: '", msg, "'"))
}
```

Running the API
========================================================


```r
library(plumber)
r <- plumb("Advanced/06_plumber/plumber.R")
r$run(port = 8000)
```

Swagger
========================================================

> [Swagger](https://swagger.io/) is an open source tool for API development

- Creates documentation for your API
- Let you test your endpoints

Example Plot Endpoint
========================================================


```r
#* Example of customizing graphical output
#* @png (width = 400, height = 500)
#* @get /plot
function(){
  print(
    ggplot(iris) +
    geom_point(aes(Sepal.Length, Sepal.Width, color = Species))
  )
}
```

Example htmlwidget Endpoint
========================================================


```r
#* @serializer htmlwidget
#* @get /map
function(){
  leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The start of R")
}
```

Hosting
========================================================

- [Rstudio Connect](https://www.rstudio.com/products/connect/), min $24,995/yr
- [Digital Ocean](https://www.digitalocean.com/), price depending on usage
- [AWS](https://aws.amazon.com/), using this line `r$run(host = "0.0.0.0", port = 8000)`

Exercise
========================================================

Create an API with the following endpoints:

- Gives back a location on a map depending on the coordinates provided by the user
- Gives back a graph of the `iris` data where the user can decide on the axis
