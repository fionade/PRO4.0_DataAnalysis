library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Time Series Analysis"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", label = h3("Date"),
                     start = "2015-04-16",
                     min = min(all_wide_smooth$timestamp),
                     max = max(all_wide_smooth$timestamp),
                     format = "yyyy-mm-dd",
                     startview = "month", weekstart = 0, language = "en",
                     separator = " to "),
      sliderInput("hour_range", label= h3("Hours of the day"),
                  min = 0, max = 24, value = c(14, 15)),
      sliderInput("limits", label= h3("Minimum/maximum value on y axis"),
                  min = 0, max = 1023, value = c(0, 1023)),
      checkboxGroupInput("Vars", label = h3("Sensors"),
                   choices = colnames(all_wide_smooth)[3:ncol(all_wide_smooth)-1]
      ),
      checkboxGroupInput("ScreenshotVars", label = h3("Screenshot Variables"),
                         choices = colnames(screenshots)[4:ncol(screenshots)-2]
      ),
      checkboxGroupInput("audioVars", label = h3("Audio Variables"),
                         choices = colnames(audio)[3:ncol(audio)-1]
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("timePlot")
    )
  )
))