library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Correlation Analysis"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", label = h3("Date"),
                     start = min(laser$timestamp), end = max(laser$timestamp),
                     format = "yyyy-mm-dd",
                     startview = "month", weekstart = 0, language = "en",
                     separator = " to "),
      sliderInput("hour_range", label= h3("Hours of the day"),
                  min = 0, max = 24, value = c(0, 24)),
      radioButtons("xVar", label = h3("Sensor on x axis"),
                   choices = colnames(laser)[4:ncol(laser)-1]                   
      ),
      radioButtons("yVar", label = h3("Sensor on y axis"),
                   choices = colnames(laser)[4:ncol(laser)-1]                 
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("correlationCoefficient")
    )
  )
))