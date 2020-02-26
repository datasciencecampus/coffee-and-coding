
# Load the required libraries
library(shiny)
library(ggplot2)

# Define the UI for application that subsets the mtcars dataset
ui = fluidPage(
  selectInput("column_selection", "Select columns to display", names(mtcars), multiple = TRUE),
  h2('The mtcars data'),
  dataTableOutput('mytable')
)

# Define server logic for application that subsets the mtcars dataset
server <-  function(input, output) {
  output$mytable <-  renderDataTable({
    columns <-  names(mtcars)
    if (!is.null(input$column_selection)) {
      columns <-  input$column_selection
    }
    mtcars[,columns]
  })
}

# Run the application 
shinyApp(ui, server)