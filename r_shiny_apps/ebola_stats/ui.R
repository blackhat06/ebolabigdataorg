library(shiny)
library(gdata)

eboladata = read.xls("/srv/shiny-server/ebola_data.xls")




# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Ebola Outbreak(2014) - Worldwide"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("Death", "Death:", 
                    choices=colnames(eboladata)),
        hr(),
        helpText("Data from CDC , last 9 months of ebola outbreak.")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("barPlot") 
      )
      
    )
  )
)
