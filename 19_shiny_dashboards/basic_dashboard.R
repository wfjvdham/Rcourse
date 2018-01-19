library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),

      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    ),
    fluidRow(
      infoBoxOutput("mean"),
      valueBoxOutput("max")
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$mean <- renderInfoBox({
    infoBox(
      "mean_value",
      color = "yellow",
      icon = icon("arrows"),
      value = round(mean(histdata[seq_len(input$slider)]))
    )
  })
  
  output$max <- renderValueBox({
    valueBox(
      "max",
      color = "green",
      icon = icon("calendar"),
      value = round(max(histdata[seq_len(input$slider)]))
    )
  })
  
}

shinyApp(ui, server)

