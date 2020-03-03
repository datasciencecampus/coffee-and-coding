library(shiny)
library(markdown)

# Some markdown in a string - can use markdown or other files as well
# The markdownToHTML() can be fussy about syntax:
  # Avoid indentations in the text - indentations before heading tags stop them from working properly
  # Heading tags must have a space between the tag and the text
  # Avoid line breaks before heading tags as well
  # * and ** tags should NOT be separated from the text by a space or they break
text = "# Markdown with R Shiny
## Example:
Here is some **markdown** text presented in R Shiny. This is done using the **markdownToHTML()** function:
- Load the markdown library: **library(markdown)**
- Use markdownToHTML: **markdownToHTML(text = 'any markdown', fragment.only = TRUE)**
  - You need **fragment.only** to be true so the function doesn't output a whole HTML page
- Here is a working [link](https://www.google.com)
"

# Using the markdownToHTML() function inside an HTML tag will display the markdown on the page, using the same styling as the dashboard
ui <- basicPage(HTML(
  
  # The function looks for a file by detault, so "text = " has to be used if using a string
  # "fragment.only = TRUE" ensures the function only outputs the content without the rest of an HTML page
  markdownToHTML(text = text, fragment.only = TRUE)
))

server <- function(input, output) {
  
}

shinyApp(ui, server)
