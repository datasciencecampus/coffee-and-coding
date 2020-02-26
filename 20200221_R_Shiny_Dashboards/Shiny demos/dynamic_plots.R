# This app can dynamically generate and remove plots based on user inputs 

library(shiny)
library(ggplot2)

# Set up data for bar plot
df <- as.data.frame(apply(mtcars, 2, mean))
colnames(df) <- c("mean")
df$cat <- rownames(df)
rownames(df) <- c(1:nrow(df))

# A variable to keep track of which plots have been created
plotList <- c()

# Add a new chart if the same chart does not already exist
addChart <- function(data, filters, input, output) {
  
  # We can write a function to generate any number of similar objects by dynamically creating unique IDs
  id <- gsub(", ", "", toString(as.numeric(filters)))
  if (!id %in% plotList) {
    
    # "Shiny.setInputValue()" sends a reactive value from JavaScript to R, meaning we can use the same function with multiple html objects
    
    insertUI("#plots", where = 'beforeEnd', 
             wellPanel(id = paste0("panel", id, sep = ""),
                       
                       # The "Close" button sends the panel's ID to R shiny as input$closeWell
                       actionButton("close", icon("times"), onClick = paste0("Shiny.setInputValue('closeWell', '", id, "', {priority: 'event'})")),
                       plotOutput(paste0("plot", id)))
             )
     output[[paste0("plot", id)]] <- renderPlot({
       ggplot(data, aes(x = cat, y = mean)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()
     })
     plotList <<- append(plotList, id)
   }
}

# Create R Shiny page
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
      # R Shiny input and output objects can be created using vectorised functions
      # This function takes all mtcars column names (car models) and uses them to generate the object
      lapply(colnames(mtcars), function(x){
        checkboxInput(x, x, TRUE)}
      ),
      actionButton("add", "Add", icon("chart-bar"))
    ),
    mainPanel(id = "plots", wellPanel(plotOutput("plot")))
  )
)

# R Shiny server functions
server <- function(input, output, session){
  
  # Plot output
  output$plot <- renderPlot({
    ggplot(df, aes(x = cat, y = mean)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()
  })
  
  # Create new plot when "add" button is pressed
  observeEvent(input$add, {
    filters <- c(input$mpg, input$cyl, input$disp, input$hp, input$drat, input$wt, input$qsec, input$vs, input$am, input$gear, input$carb)
    addChart(df[filters, ], filters, input, output)
  })
  
  # Close plot panel if the panel's close button is pressed
  observeEvent(input$closeWell, {
    plotList <<- plotList[!plotList == input$closeWell]
    removeUI(paste0("#panel", input$closeWell))
  })
}

shinyApp(ui = ui, server = server, options = list(display.mode = 'showcase'))