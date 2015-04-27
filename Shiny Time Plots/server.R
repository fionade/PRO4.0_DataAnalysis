library(shiny)
library(ggplot2)
library(reshape2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$timePlot <- renderPlot({
    sensors <- input$laserVar
    min_date <- input$date_range[1]
    max_date <- input$date_range[2]
    min_time <- input$hour_range[1]
    max_time <- input$hour_range[2]
    
    data <- laser
    # date filter
    subset <- subset(data, data$timestamp >= as.POSIXct(min_date) & data$timestamp <= as.POSIXct(max_date))
    # time of day filter
    subset <- subset(subset, data$hour >= min_time & data$hour <= max_time)

    subset_long <- melt(subset, id.vars=c("row_name", "timestamp", "hour"), measure.vars=sensors)
    
    print(ggplot(subset_long) + geom_line(aes(x = timestamp, y=value, group=variable, colour=variable)) + ylim(0, 1023))
  })
})