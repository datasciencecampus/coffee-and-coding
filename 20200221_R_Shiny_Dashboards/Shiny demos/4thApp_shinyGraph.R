# load the required libraries
library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("My first shiny graph!"),
    selectInput("x_axis", "Select x variable to display", names(mtcars)),
    selectInput("y_axis", "Select y variable to display", names(mtcars), selected = "cyl"),
    
    plotOutput("graph_output")
        )

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$graph_output <- renderPlot({
    
    # read in the data
    ggplot(mtcars)+
      
      # initialise the scatter plot
      geom_point(aes_string(input$x_axis, input$y_axis, color = "cyl"), size = 5)+
      
      # specify the plot colour
      scale_color_gradient(low = "#3498DB", high = "#F39C12")+
      
      # specify axes titles
      xlab(toupper(input$x_axis))+
      ylab(toupper(input$y_axis))
    
  })

    }

# Run the application 
shinyApp(ui = ui, server = server)
