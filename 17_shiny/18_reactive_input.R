library("shiny")
sliderTextUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(ns("slider"), "Slide Me", 0, 100, 1),
    textOutput(ns("number"))
  )
}
sliderText <- function(input, output, session, show) {
  output$number <- renderText({
    if (show()) input$slider
    else NULL
  })
}
ui <- fluidPage(
  checkboxInput("display", "Show value"),
  sliderTextUI("module")
)
server <- function(input, output) {
  display <- reactive({ input$display })
  callModule(sliderText, "module", display)
}
shinyApp(ui, server)
