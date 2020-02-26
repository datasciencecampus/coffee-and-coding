# R Shiny reference sheet
Below are some useful links for people getting started with R Shiny.

## R Shiny website
The [R Shiny website](https://shiny.rstudio.com/) contains a lot of useful information:
- [Tutorials](https://shiny.rstudio.com/tutorial/)
- A [gallery](https://shiny.rstudio.com/gallery/) of example applications using R Shiny
- A [reference manual](https://shiny.rstudio.com/reference/shiny/) (remember to select the version of R Shiny you are using)

## Packages for creating graphs
If you plan to display graphs in your dashboard, you will need to use a an additional package to generate them:
- [ggplot2](https://ggplot2.tidyverse.org/) can be used to easily create graphs that display in R Shiny
- [plotly](https://plot.ly/r/) is another package that can be used to create more interactive graphs

## Front end web development
If you want to be able to modify the R Shiny looks and acts, it can be really useful to learn a little about front end web development. You don't need to know a lot ot start using these tools in your Shiny dashboards! R Shiny allows you to insert HTML, CSS and JavaScript into your application, so these are useful tools for customising your applications:
- [HTML](https://www.w3schools.com/html/) is the standard markup language for web pages. R Shiny has a lot of in-built functions that generate HTML code for you, but for some content you might have to write your own HTML snippets.
- [CSS](https://www.w3schools.com/css/) is the language used to style your HTML. You can easily use this to change fonts, colours, layouts, etc. R Shiny comes with default styles, but you can override these with your own CSS styles.
- [JavaScript](https://www.w3schools.com/js/) is used to programme the events that take place on the web page, at the user end. This codde executes inside the browser. Again, R Shiny has some of its own JavaScript, but you can add your own code. You can also [communicate between JavaScript and R Shiny](https://shiny.rstudio.com/articles/communicating-with-js.html). There is some example code in this repository that uses snippets of JavaScript to create customised R Shiny applications.
- [Bootstrap](https://www.w3schools.com/bootstrap/) is a widely used front end web development framework, used by R Shiny. Because it's built into R Shiny you can easily use it with your custom HTML/CSS/JavaScript code. If you want to customise how R Shiny objects look you will need to override the relevant Bootstrap classes. 
