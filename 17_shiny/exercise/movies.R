# Load packages -----------------------------------------------------
library(shiny)
library(ggplot2)

# Load data ---------------------------------------------------------
load("data/movies.Rdata")

# Define UI ---------------------------------------------------------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
    ),
    
    # Output: Show scatterplot
    mainPanel(
    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {

}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)

