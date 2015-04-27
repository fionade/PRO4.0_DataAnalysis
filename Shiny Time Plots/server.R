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
    printer_sensors <- input$printerVar
    laser_sensors <- input$laserVar
    min_date <- input$date_range[1]
    max_date <- input$date_range[2]
    min_time <- input$hour_range[1]
    max_time <- input$hour_range[2]
    
    # date filter
    laser_subset <- subset(laser, laser$timestamp >= as.POSIXct(min_date) & laser$timestamp <= as.POSIXct(max_date))
    printer_subset <- subset(printer, printer$timestamp >= as.POSIXct(min_date) & printer$timestamp <= as.POSIXct(max_date))

    # time of day filter
    laser_subset <- subset(laser_subset, laser_subset$hour >= min_time & laser_subset$hour <= max_time)
    printer_subset <- subset(printer_subset, printer_subset$hour >= min_time & printer_subset$hour <= max_time)

    # wide to long format
    laser_subset <- melt(laser_subset, id.vars=c("row_name", "timestamp", "hour"), measure.vars=laser_sensors)
    laser_subset$machine <- "laser"
    printer_subset <- melt(printer_subset, id.vars=c("row_name", "timestamp", "hour"), measure.vars=printer_sensors)
    printer_subset$machine <- "printer"
    
    data <- rbind(laser_subset, printer_subset)
    
    print(ggplot(data)
          + geom_line(aes(x = timestamp, y=value, group=variable, colour=variable))
          + ylim(0, 1023))
  })
})