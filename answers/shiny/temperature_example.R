library(shiny)
library(nycflights13)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      uiOutput("month_checkbox")
    ),
    mainPanel(
      plotOutput("avg_temp_plot")
    )
  )
)

server <- function(input, output) {
  
  weather <- read.delim(
    file = "http://stat405.had.co.nz/data/weather.txt",
    stringsAsFactors = FALSE
  ) %>%
    gather(d1:d31, key = "day", value = "temperature", na.rm = TRUE) %>%
    spread(key = "element", value = "temperature")
  
  output$month_checkbox <- renderUI({
    months <- unique(weather$month) %>%
      set_names(unique(weather$month))
    checkboxGroupInput(
      "checkGroup", 
      label = h3("Select Month"), 
      choices = months,
      selected = 1
    )
  })
  
  output$avg_temp_plot <- renderPlot({
    weather %>%
      group_by(month) %>%
      summarise(avg_min = mean(TMIN),
                avg_max = mean(TMAX)) %>%
      gather(2:3, key="temptype", value="temp") %>%
      filter(month %in% input$checkGroup) %>%
      ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
      geom_bar(position="dodge", stat="identity") +
      labs(title = "Average min and max temperature per month", x = "month")
  })
}

shinyApp(ui = ui, server = server)
