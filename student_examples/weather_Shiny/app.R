#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


####################################################



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Weather"),
   
   tabsetPanel(
       tabPanel("Temperature for day for month", 
                # Sidebar with a slider input for number of bins 
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("month",
                                "Number of month:",
                                min = 1,
                                max = 12,
                                value = 30)
                  ),
                  
                  # Show a plot of the generated distribution
                  mainPanel(
                    plotOutput("distPlot")
                  )
                )
                ),
      tabPanel("Mean temepature for month",
                #check box
                checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                                   choices = list("month 1" = 1,
                                                  "month 2" = 2,
                                                  "month 3" = 3,
                                                  "month 4" = 4,
                                                  "month 5" = 5,
                                                  "month 6" = 6,
                                                  "month 7" = 7,
                                                  "month 8" = 8,
                                                  "month 9" = 9,
                                                  "month 10" = 10,
                                                  "month 11" = 11,
                                                  "month 12" = 12)),
                
                plotOutput("hist")
                ),
       tabPanel("tab 3", 
                radioButtons("radio", label = h3("Radio buttons"),
                             choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                             selected = 1),
                plotOutput("tempOne")    
                ))
   
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  ###########
  # load data
  
  weather <- read.delim(
    file = "http://stat405.had.co.nz/data/weather.txt",
    stringsAsFactors = FALSE
  )
  
  #gather all the columns with treathments codes
  weather1 <- weather %>% 
    gather(d1:d31, key = "Day", value = "cases", na.rm = TRUE)
 
  #File to column
  weather2 <- weather1 %>% 
    spread(element,cases)
  
  #Drop word "d" of de Day and drop columns don't have information 
  weather3 <- weather2 %>%
    mutate(day = substr(Day,2,length(Day))) %>%
    select(-Day,-id) %>%
    arrange(month,day)
  
  ###########
  weatherT <- weather %>%
    gather(d1:d31, key = "day", value = "temperature", na.rm = TRUE)
  
  weatherT <- weatherT %>%
    spread(key = "element", value = "temperature")
  ###############33
  #Display:
  
   output$distPlot <- renderPlot({
     
     ggplot(weather3 %>% filter(month == input$month)) + 
       geom_point(aes(factor(day), TMAX),stat = "identity", shape = 18, size = 5) + 
       geom_point(aes(factor(day), TMIN),stat = "identity", shape = 18, size = 5) + 
       ggtitle(paste("Mont:: ", month.name[input$month]) ) +
       ylab("Temperature") +
       xlab("Days of month")
   })

   output$hist <- renderPlot({
     weatherT %>%
       group_by(month) %>%
       summarise(avg_min = mean(TMIN),
                 avg_max = mean(TMAX)) %>%
       gather(2:3, key="temptype", value="temp") %>%
       filter(month %in% input$checkGroup) %>%
       ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
       geom_bar(position="dodge", stat="identity")
   })
   
   output$tempOne <- renderPlot({
     input$checkGroup
     weatherT %>%
       group_by(month) %>%
       summarise(avg_min = mean(TMIN),
                 avg_max = mean(TMAX)) %>%
       gather(2:3, key="temptype", value="temp") %>%
       filter(month == input$radio) %>%
       ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
       geom_bar(position="dodge", stat="identity")
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

