library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 25, min = 1, max = 100),
  plotOutput("hist"),
  verbatimTextOutput("stats")
)

server <- function(input, output) {
  
  #data es un funcion
  #y es cached
  data <- reactive({
    rnorm(input$num)
  })
  
  output$hist <- renderPlot({
    hist(data())
  })
  output$stats <- renderPrint({
    summary(data())
  })
  #output$hist <- renderPlot({
  #  hist(rnorm(input$num))
  #})
  #output$stats <- renderPrint({
  #  summary(rnorm(input$num))
  #})
}

shinyApp(ui = ui, server = server)
