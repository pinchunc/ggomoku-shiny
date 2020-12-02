server <- function(input, output) {
  require(ggomoku)
  output$ggplot <- renderPlot({
    gomoku_board()
  })
}