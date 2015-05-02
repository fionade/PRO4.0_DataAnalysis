library(shiny)
library(ggplot2)
library(reshape2)

filter <- function(data.frame, min.date, max.date, min.time, max.time, sensors) {
  # date filter
  tmp <- subset(data.frame, data.frame$timestamp >= as.POSIXct(min.date) & data.frame$timestamp <= as.POSIXct(max.date))
  # time of day filter
  tmp <- subset(tmp, tmp$hour >= min.time & tmp$hour <= max.time)
  # reshape wide to long
  tmp <- melt(tmp, id.vars=c("timestamp", "hour"), measure.vars=sensors)
  return(tmp)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$timePlot <- renderPlot({
    printer.sensors <- input$printerVar
    laser.sensors <- input$laserVar
    cnc.sensors <- input$cncVar
    room.sensors <- input$roomVar
    min.date <- input$date_range[1]
    max.date <- input$date_range[2]
    min.time <- input$hour_range[1]
    max.time <- input$hour_range[2]
    
    data <- data.frame()
    
    if (length(laser.sensors) > 0) {
      laser_subset <- filter(laser, min.date, max.date, min.time, max.time, laser.sensors)
      data <- rbind(data, laser_subset)
    }
    
    if (length(printer.sensors) > 0) {
      printer_subset <- filter(printer, min.date, max.date, min.time, max.time, printer.sensors)
      data <- rbind(data, printer_subset)
    }
    
    if (length(cnc.sensors) > 0) {
      cnc_subset <- filter(cnc, min.date, max.date, min.time, max.time, cnc.sensors)
      data <- rbind(data, cnc_subset)
    }
    
    if (length(room.sensors) > 0) {
      room_subset <- filter(room, min.date, max.date, min.time, max.time, room.sensors)
      data <- rbind(data, room_subset)
    }
    
    # time and date filter for survey
    survey_subset <- subset(survey, survey$timestamp >= as.POSIXct(min.date) & survey$timestamp <= as.POSIXct(max.date))    
    survey_subset <- subset(survey_subset, survey_subset$hour >= min.time & survey_subset$hour <= max.time)
    
    print(ggplot(data)
          + geom_line(aes(x = timestamp, y=value, group=variable, colour=variable))
          + ylim(input$limits[1], input$limits[2])
          + geom_point(data=survey_subset, aes(x = timestamp, y = pseudoValue, shape=machineOutcome),
                       size = 4)
          )
  })
})