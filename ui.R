ui <- fluidPage(
  selectInput("var", "Variable", names(data)),
  numericInput("bins", "bins", 10, min = 1),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

