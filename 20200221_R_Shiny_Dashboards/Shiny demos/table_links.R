# This app contains customised interactive objects inside a data table
library(shiny)
library(DT)

# Function to create action link from a inside data frame rows
create_link <- function(row) {
  
  # Generate a unique ID using the car model name
  id <- gsub(" ", "", row["model"])
  
  # Generate an action link object using the unique ID and car model name
  # onClick functions are JavaScript functions that executure when the object is clicked
  # Shiny.setInputValue() sends a reactive value to R Shiny
  link <- actionLink(id, row["model"], onclick = paste0("Shiny.setInputValue('link', '", row["model"], "', {priority: 'event'})"))
  
  # Convert to a link to get the HTML as a string, rather than returning an object. The datatable will display this as HTML
  return(toString(link))
}

# Define the UI for application that outputs a data table 
ui <- fluidPage(
  DT::dataTableOutput('carTable')
)

# Server functions
server <- function(input, output, session){
  
  # Set up data frame
  df <- mtcars
  df$model <- rownames(df)
  rownames(df) <- c(1:length(rownames(df)))
  df <- df[, c(12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)]
  
  # Convert "model" column values to hyperlinks (HTML code)
  df$model <- apply(df, 1, create_link)
  
  # Set up server logic for data table
  output$carTable <- DT::renderDataTable(df, escape = FALSE)
  
  # Display URL with query string when the the "link" button is clicked
  observeEvent(input$link, { 
    
    # Display a modal object
    showModal(modalDialog(
      tags$img(src = paste0(input$link, ".jpg"), width = "100%"),
      easyClose = TRUE
    ))
    }
  )
}

shinyApp(ui = ui, server = server)
