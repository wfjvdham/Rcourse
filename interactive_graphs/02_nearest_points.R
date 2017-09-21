library("ggplot2")

ui <- basicPage(
  plotOutput("plot1", click = "plot_click", width = 400),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point()
  })

  output$info <- renderPrint({
    row <- nearPoints(mtcars, input$plot_click,
      threshold = 5, maxpoints = 1)

    cat("Nearest point within 5 pixels:\n")
    print(row)
  })
}

shinyApp(ui, server)
