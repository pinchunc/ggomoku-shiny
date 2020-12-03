server <- function(input, output) {
  
  output$game <- renderPlot({gomoku_board(input$board_size)})
  
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  # Adds piece to the plotted grid
  output$game <- renderGirafe({
    add_tiles(input$x_coord,  input$y_coord,  board , "black")
  })
}
