# load the required libraries
library(shinydashboard)
library(ggplot2)

# Define the UI needed for user inputs to change graph and table produced. Note we're now using the
# 'dashboardPage' layout, unique to shinydashboard
ui <- dashboardPage(
  
  # here we specify a header for the dashboard
  dashboardHeader(title = "mtcars dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("application description", tabName = "description", icon = icon("info")),
      menuItem("data viewer", tabName = "dataviewer", icon = icon("dashboard"))
    )
  ), # end of sidebar, where we have specified two different tabs: 'application description' 
  # and 'data viewer'

  dashboardBody(
    tabItems(
      tabItem("description",
              h1("Description of Application"),
              p("This is a basic application in Shinydashboard to show how to create a dynamic graph")
              ),# end of description tab item
      
      tabItem("dataviewer",
    sidebarLayout(
        sidebarPanel(
        h1("Customise your graph", align = "center"),
        selectInput("x_axis", "Select x variable to display", names(mtcars)),
        
        selectInput("y_axis", "Select y variable to display", names(mtcars), selected = "cyl")
        ), # end of sidebarPanel
      
      mainPanel(
        h1(textOutput("graph_title"), align = "center"),
        plotOutput("graph_output")
      )# end of mainPanel
      
    )# end of sidebarLayout
    
      ))# end of tabItems
  )
)
# Define the server logic needed for user inputs to change graph and table produced
server <-  function(input, output) {
  
  # first output, to dynamically update graph title on user axes selection
  output$graph_title <- renderText({
    paste0("Graph to show relationship between ", input$x_axis," and ", input$y_axis)
  })
  
  # second output, to change graph based on user axes selection
  output$graph_output <- renderPlot({
    
    # read in the data (note we're using ggplot for this graph output)
    ggplot(mtcars)+
      
      # initialise the scatter plot. aes_string lets us use strings to define
      # the 'aesthetic mappings', rather than using complicated expressions
      geom_point(aes_string(input$x_axis, input$y_axis, color = "cyl"), size = 5)+
      
      # specify the plot colour
      scale_color_gradient(low = "#3498DB", high = "#F39C12")+
      
      # specify axes titles. toupper() changes these to upper case
      xlab(toupper(input$x_axis))+
      ylab(toupper(input$y_axis))
    
  })
  
}

# Run the application
shinyApp(ui, server)