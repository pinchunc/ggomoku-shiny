library(shiny)
board_size <- 19
ui <- fluidPage(
  # *Input
  numericInput(inputId = "num_x", label = "Choose a number for x coordinate",
               value = 1, min = 1, max = board_size),
  numericInput(inputId = "num_y", label = "Choose a number for x coordinate",
               value = 1, min = 1, max = board_size),
  # *Output
  plotOutput("ggplot"))

server <- function(input, output) {
  output$ggplot <- renderPlot({
    title <- "100 random normal value"
    plot(c(input$num_x, input$num_y), main = title)
    })
}

shinyApp(ui = ui, server = server)
