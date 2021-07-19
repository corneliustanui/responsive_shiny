server <- function(input, output, session) {
  
  # load packages
  library(tidyverse)
  library(flexdashboard)
  library(shiny)
  library(plotly)
  library(DT)
  library(ggplot2)
  library(ggpmisc)

    data <- reactive(mtcars[[input$var]])
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
}
