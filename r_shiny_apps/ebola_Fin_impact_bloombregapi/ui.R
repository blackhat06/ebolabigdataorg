library(shiny)
library(gdata)

eboladata = read.xls("/srv/shiny-server/bloomberg_api.xls")


# Define the overall UI
shinyUI(

  # Use a fluid Bootstrap layout
  fluidPage(

    # Give the page a title
    titlePanel("Last 10 days volume traded at Dow - Ebola Related Firms"),

    # Generate a row with a sidebar
    sidebarLayout(

      # Define the sidebar with one input
      sidebarPanel(
        selectInput("Outstanding", "Oustanding:",
                    choices=colnames(eboladata)),
        hr(),
        helpText("Data from Bloomberg API , using node.js.")
      ),

      # Create a spot for the barplot
      mainPanel(
        plotOutput("barPlot")
      )

    )
  )
)