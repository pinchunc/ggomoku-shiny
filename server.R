server <- function(input, output) {
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  board <- gomoku_board(board_size)
  # Adds piece to the plotted grid
  output$stateplot <- renderGirafe({
    add_tiles(values$state)
  })
}
