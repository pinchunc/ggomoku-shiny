library(shiny)
library(ggomoku)
library(rsconnect)

board_size <- 19

shinyApp(ui = ui, server = server)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # *Input
      numericInput(inputId = "num_x", label = "Choose a number for x coordinate",
                   value = 1, min = 1, max = board_size),
      numericInput(inputId = "num_y", label = "Choose a number for y coordinate",
                   value = 1, min = 1, max = board_size)
      ),
    
    mainPanel(
      # *Output
      plotOutput("ggplot")
    )
  )
)

#server <- function(input, output) {
#  output$ggplot <- renderPlot({
#    title <- "100 random normal value"
#    plot(c(input$num_x, input$num_y), main = title)
#    })
#}

server <- function(input, output) {
  require(ggomoku)
  output$ggplot <- renderPlot({
    gomoku_board()
  })
  
}

shinyApp(ui = ui, server = server)
