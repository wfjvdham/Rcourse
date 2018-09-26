library(shiny)
library(nycflights13)
library(tidyverse)
library(promises)
library(future)
library(lubridate)

get_flights <- function() {
  future({
    Sys.sleep(5)
    flights
  })
}

get_airports <- function() {
  future({
    Sys.sleep(5)
    airports
  })
}

ui <- fluidPage(
  titlePanel("Fast App"),
  plotOutput("flight_plot"),
  p("number of airports in this dataset"),
  textOutput("n_airports"),
  p("10 flights from highest airports"),
  tableOutput("high_airports")
)

server <- function(input, output) {
  
  print(now())
  
  output$flight_plot <- renderPlot({
    result <- get_flights() %...>% {
      flights_df <- .
      ggplot(flights_df) +
        geom_bar(aes(dep_delay > 0)) +
        labs(title = "Number of flights that leave with/without a delay")
    }
    print(now())
    result
  })
  
  output$n_airports <- renderText({
    result <- get_airports() %...>%
      nrow()
    print(now())
    result
  })
  
  output$high_airports <- renderTable({
    result <- promise_all(f = get_flights(), a = get_airports()) %...>% with({
      f %>%
        sample_n(100) %>%
        inner_join(a, by = c("origin" ="faa")) %>%
        arrange(desc(alt)) %>%
        slice(1:10)
    })
    print(now())
    result
  })
}

shinyApp(ui = ui, server = server)

