# load the required library
library(shinydashboard)

# Define the UI needed for user inputs to change graph and table produced
ui <- dashboardPage(
  
# Start of header
  dashboardHeader(),
  
# Start of sidebar
  dashboardSidebar(),

# Start of body
  dashboardBody(
    sidebarLayout(
      
      sidebarPanel(
        h1("Customise your graph", align = "center"),
        selectInput("x_axis", "Select x variable to display", names(mtcars)),
        
        selectInput("y_axis", "Select y variable to display", names(mtcars), selected = "cyl")
        
      ), # end of sidebarPanel
      mainPanel(
        h1("This is the main panel", align = "center"),
        plotOutput("graph_output")
      )# end of mainPanel
      
    )# end of sidebarLayout
  )
)
# Define the server logic needed for user inputs to change graph and table produced
server <-  function(input, output) {
  
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
shinyApp(ui, server)