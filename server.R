server <- function(input, output) {
<<<<<<< HEAD
  require(ggomoku)
  # output$ggplot <- renderPlot({
  #   gomoku_board()
  # })
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  board <- gomoku_board(board_size)
  # Adds piece to the plotted grid
  add_tile <- reactive({annotate("point", x = input$num_x, y = input$num_y, size = 6.5, colour = color)
  })
=======
>>>>>>> 793f7a6445e2416c5e357377d86367a36cff5000
  output$ggplot <- renderPlot({
    board + add_tile
  })
  
<<<<<<< HEAD
}
=======
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
}
>>>>>>> 793f7a6445e2416c5e357377d86367a36cff5000
