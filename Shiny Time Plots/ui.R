library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Correlation Analysis"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", label = h3("Date"),
                     start = min(min(laser$timestamp), min(printer$timestamp)),
                     end = max(max(laser$timestamp), max(printer$timestamp)),
                     format = "yyyy-mm-dd",
                     startview = "month", weekstart = 0, language = "en",
                     separator = " to "),
      sliderInput("hour_range", label= h3("Hours of the day"),
                  min = 0, max = 24, value = c(0, 24)),
      checkboxGroupInput("printerVar", label = h3("3D printer sensors"),
                   choices = colnames(printer)[4:ncol(printer)-1],
                   selected = "acc_board_x"
      ),
      checkboxGroupInput("laserVar", label = h3("Laser cutter sensors"),
                   choices = colnames(laser)[4:ncol(laser)-1],
                   selected = "current"
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("timePlot")
    )
  )
))