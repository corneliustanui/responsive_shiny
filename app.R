# load shiny package 
library(shiny)

# load user interface
source("ui.R")

# load server
source("server.R")

# combine ui and server
shinyApp(ui, server)

