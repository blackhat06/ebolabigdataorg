library(shiny)
library(gdata)

eboladata = read.xls("/srv/shiny-server/bloomberg_api.xls")


# Define a server for the Shiny app
shinyServer(function(input, output) {

  # Fill in the spot we created for a plot
  output$barPlot <- renderPlot({

    # Render a barplot
    barplot(eboladata[,input$Outstanding],
            main=input$Outstanding,
            names.arg=c("Lakeland Industries","Alpha Pro Tech","Chimerix","Tekmira Pharam"),
            ylab="Number of Million shares traded!",
            xlab="Stock traded over last 10 days")
  })
})