library(shiny)

ui <- fluidPage(
  fluidRow(
    column(2, sliderInput(inputId = "num", 
                          label = "Choose a number", 
                          value = 25, min = 1, max = 100))
  ),
  fluidRow(
    column(3, plotOutput("hist"), offset = 1)
  )
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num))
  })
}

shinyApp(ui = ui, server = server)
