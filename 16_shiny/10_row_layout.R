library(shiny)

ui <- fluidPage(
  fluidRow(
    column(5, sliderInput(inputId = "num", 
                          label = "Choose a number", 
                          value = 25, min = 1, max = 100)),
    column(4, plotOutput("hist")
    )
  )
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num))
  })
}

shinyApp(ui = ui, server = server)
