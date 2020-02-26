library(shiny)

#----------Return pressed key on key up------------
# returns name of key pressed on release. For key down events, use onkeydown
# put this snippet in the ui function
# Shiny.setInputValue: first argument = name of input variable, second argument = value of input variable, final argument gets R Shiny to react to input even if value hasn't changed
HTML(
  '<script> 
      window.onkeyup = function(e) {
         Shiny.setInputValue("keyPressed", String(e.key), {priority: "event"})
      }
    </script>'
)