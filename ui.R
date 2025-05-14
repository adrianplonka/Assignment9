library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Gene Expression Viewer"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "gene", 
          label   = "Select Gene ID:",
          choices = NULL          
        )
      ),
      mainPanel(
        plotOutput("exprPlot")
      )
    )
  )
)
