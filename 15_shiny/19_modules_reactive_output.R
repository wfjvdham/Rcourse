library("shiny")
sliderTextUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(ns("slider"), "Slide Me", 0, 100, 1)
  )
}
sliderText <- function(input, output, session, show) {
  output$number <- renderText({ input$slider })
  reactive({input$slider})
}
ui <- fluidPage(
  sliderTextUI("module"),
  h2(textOutput("value"))
)
server <- function(input, output) {
  num <- callModule(sliderText, "module", display)
  output$value <- renderText({num()})
}
shinyApp(ui, server)
