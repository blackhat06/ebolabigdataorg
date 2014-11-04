library(shiny)
library(gdata)

eboladata = read.xls("/srv/shiny-server/ebola_data.xls")



# Define a server for the Shiny app
shinyServer(function(input, output) {

  # Fill in the spot we created for a plot
  output$barPlot <- renderPlot({

    # Render a barplot
    barplot(eboladata[,input$Death],
            main=input$Death,
            ylab="Number of $var",
            xlab="Months", col="skyblue")
  })
})
