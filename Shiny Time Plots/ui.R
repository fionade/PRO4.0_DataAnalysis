library(shiny)

if (!(exists("laser"))) {
  laser <- data.frame(none = 0)
}

if (!(exists("printer"))) {
  printer <- data.frame(none = 0)
}

if (!(exists("cnc"))) {
  cnc <- data.frame(none = 0)
}

if (!(exists("room"))) {
  room <- data.frame(none = 0)
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Correlation Analysis"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", label = h3("Date"),
                     start = "2015-04-16",
                     min = min(min(laser$timestamp), min(printer$timestamp)),
                     max = max(max(laser$timestamp), max(printer$timestamp)),
                     format = "yyyy-mm-dd",
                     startview = "month", weekstart = 0, language = "en",
                     separator = " to "),
      sliderInput("hour_range", label= h3("Hours of the day"),
                  min = 0, max = 24, value = c(14, 15)),
      checkboxGroupInput("printerVar", label = h3("3D printer sensors"),
                   choices = colnames(printer)[4:ncol(printer)-1],
                   selected = "acc_board_x"
      ),
      checkboxGroupInput("cncVar", label = h3("CNC mill sensors"),
                         choices = colnames(cnc)[4:ncol(cnc)-1]
      ),
      checkboxGroupInput("laserVar", label = h3("Laser cutter sensors"),
                   choices = colnames(laser)[4:ncol(laser)-1],
                   selected = "current"
      ),
      checkboxGroupInput("roomVar", label = h3("Room sensors"),
                         choices = colnames(room)[4:ncol(room)-1]
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("timePlot")
    )
  )
))