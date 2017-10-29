library(shiny)


ui <- fluidPage(
  sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 25, min = 1, max = 100),
  actionButton(inputId = "btnColor", 
               label = "red" ),
  #fluidRow(column(2, verbatimTextOutput("value"))),
  plotOutput("hist")
)

server <- function(input, output) {
  
  output$hist <- renderPlot({
    hist(rnorm(input$num))
  })
  
  #output$value <- renderPrint({ input$btnColor })
  
  reactive({
    randomNumbers<-rnorm(input$num)
  })
  
  observeEvent(input$btnColor, {
    output$hist <- renderPlot({
      #print(randomNumbers)
      hist(rnorm(input$num), col="red")
    })
    
    
  })
}

shinyApp(ui = ui, server = server)
