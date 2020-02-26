# This app can read a query string to pre-load settings when starting the application 

library(shiny)
library(ggplot2)

# Set up data for bar plot
df <- as.data.frame(apply(mtcars, 2, mean))
colnames(df) <- c("mean")
df$cat <- rownames(df)
rownames(df) <- c(1:nrow(df))

# Get query string and extract logical arguments
getQuery <- function(session) {
  filter_list <- colnames(mtcars)
  query_string <- (isolate(session$clientData$url_search))
  filter_list <- lapply(filter_list, function(x){
    ifelse(grepl(paste0(x, "=", "FALSE"), query_string), FALSE, TRUE)
  })
  return(unlist(filter_list))
}

# Update all checkboxes based on input
update_checks <- function(session, filters) {
  updateCheckboxInput(session, "mpg", value = filters[1])
  updateCheckboxInput(session, "cyl", value = filters[2])
  updateCheckboxInput(session, "disp", value = filters[3])
  updateCheckboxInput(session, "hp", value = filters[4])
  updateCheckboxInput(session, "drat", value = filters[5])
  updateCheckboxInput(session, "wt", value = filters[6])
  updateCheckboxInput(session, "qsec", value = filters[7])
  updateCheckboxInput(session, "vs", value = filters[8])
  updateCheckboxInput(session, "am", value = filters[9])
  updateCheckboxInput(session, "gear", value = filters[10])
  updateCheckboxInput(session, "carb", value = filters[11])
}

# Shiny page
ui <- fluidPage(
  
  # Page with sidebar
  sidebarLayout(
    
    # Side bar contents 
    sidebarPanel(
      
      # R Shiny input and output objects can be created using vectorised functions
      # This function takes all mtcars column names (car models) and uses them to generate the object
      lapply(colnames(mtcars), function(x){
        checkboxInput(x, x, TRUE)}
      ),
      
      actionButton("update", "Update chart", icon("sync")),
      actionButton("url", "Get URL", icon("save"))
      ),
    
    # Main contents
    mainPanel(id = "plots", 
              wellPanel(plotOutput("plot"))
              )
  )
)

# Server functions - "session" argument is needed to access url
server <- function(input, output, session){
  
  # Get url (protocol, host and port)
  protocol <- (isolate(session$clientData$url_protocol))
  host <- (isolate(session$clientData$url_hostname))
  port <- (isolate(session$clientData$url_port))
  
  # Get query string (part of the url after the web address)
  filters <- getQuery(session)
  
  # Update all checkbox inputs
  update_checks(session, filters)
  
  # Render plot
  output$plot <- renderPlot({
    ggplot(df[filters, ], aes(x = cat, y = mean)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()
  })
  
  # Apply check box values as filters and update plot when the "apply" button is pressed
  observeEvent(input$update, {
    filters <- c(input$mpg, input$cyl, input$disp, input$hp, input$drat, input$wt, input$qsec, input$vs, input$am, input$gear, input$carb)
    output$plot <- renderPlot({
      ggplot(df[filters, ], aes(x = cat, y = mean)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()
    })
  })
  
  # Generate URL with query string when "Get URL" is pressed
  observeEvent(input$url, {
    filters <- c(input$mpg, input$cyl, input$disp, input$hp, input$drat, input$wt, input$qsec, input$vs, input$am, input$gear, input$carb)
    url <- paste0(protocol, host, ":", port, "/?")
    query <- paste0("mpg=", toString(filters[1]),
                   "&cyl=", toString(filters[2]),
                   "&disp=", toString(filters[3]),
                   "&hp=", toString(filters[4]),
                   "&drat=", toString(filters[5]),
                   "&wt=", toString(filters[6]),
                   "&Wqsec=", toString(filters[7]),
                   "&vs=", toString(filters[8]),
                   "&am=", toString(filters[9]),
                   "&gear=", toString(filters[10]),
                   "&carb=", toString(filters[11]))

    # Display a modal 
    showModal(
      modalDialog(title = "URL",
                  p(paste0(url, query),
                    
                    # Style arguments can be used to add custom CSS to Shiny elements - in this case, text wrapping 
                    style = "word-break: break-all !important"),
                  easyClose = TRUE)
    )
  })
}

shinyApp(ui = ui, server = server)