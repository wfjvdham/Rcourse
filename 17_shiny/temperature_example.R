library(shiny)
library(nycflights13)

ui <- fluidPage(
  checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                     choices = list("month 1" = 1, "month 2" = 2, "month 3" = 3)),
  uiOutput("radioUI"),
  plotOutput("hist"),
  plotOutput("tempOne")
)

server <- function(input, output) {
  flights <- as_data_frame(flights)
  
  weather <- read.delim(
    file = "http://stat405.had.co.nz/data/weather.txt",
    stringsAsFactors = FALSE
  )
  
  weather <- weather %>%
    gather(d1:d31, key = "day", value = "temperature", na.rm = TRUE)
  
  weather <- weather %>%
    spread(key = "element", value = "temperature")
  
  output$radioUI <- renderUI({
    radioButtons("radio", label = h3("Radio buttons"),
                 choices = c(unique(flights$origin)), 
                 selected = 1)
  })
  
  output$hist <- renderPlot({
    weather %>%
      group_by(month) %>%
      summarise(avg_min = mean(TMIN),
                avg_max = mean(TMAX)) %>%
      gather(2:3, key="temptype", value="temp") %>%
      filter(month %in% input$checkGroup) %>%
      ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
      geom_bar(position="dodge", stat="identity")
  })
  
  output$tempOne <- renderPlot({
    input$checkGroup
    weather %>%
      group_by(month) %>%
      summarise(avg_min = mean(TMIN),
                avg_max = mean(TMAX)) %>%
      gather(2:3, key="temptype", value="temp") %>%
      filter(origin == input$radio) %>%
      ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
      geom_bar(position="dodge", stat="identity")
  })
}

shinyApp(ui = ui, server = server)
