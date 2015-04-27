library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    xcol <- input$xVar
    ycol <- input$yVar
    min_date <- input$date_range[1]
    max_date <- input$date_range[2]
    min_time <- input$hour_range[1]
    max_time <- input$hour_range[2]
    
    data <- laser
    # date filter
    subset <- subset(data, data$timestamp >= as.POSIXct(min_date) & data$timestamp <= as.POSIXct(max_date))
    # time of day filter
    subset <- subset(subset, subset$hour >= min_time & subset$hour <= max_time)
    xdata <- subset[,xcol]
    ydata <- subset[,ycol]
    
    plot(xdata, ydata, xlim=c(min(xdata, na.rm=T), min(max(xdata, na.rm=T), 1023)),
         ylim=c(min(ydata, na.rm=T), min(max(ydata, na.rm=T), 1023)),
         xlab=xcol, ylab=ycol)
  })
  
  output$correlationCoefficient <- renderText({
    xcol <- input$xVar
    ycol <- input$yVar
    min_date <- input$date_range[1]
    max_date <- input$date_range[2]
    min_time <- input$hour_range[1]
    max_time <- input$hour_range[2]
    
    data <- laser
    # date filter
    subset <- subset(data, data$timestamp >= as.POSIXct(min_date) & data$timestamp <= as.POSIXct(max_date))
    # time of day filter
    subset <- subset(subset, data$hour >= min_time & data$hour <= max_time)
    xdata <- subset[,xcol]
    ydata <- subset[,ycol]
    paste("Correlation Coefficient:", cor(xdata, ydata, use = "complete.obs"))
  })
})