server <- function(input, output) {
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  board <- gomoku_board(board_size)
  # Adds piece to the plotted grid
  add_tile <- reactive({annotate("point", x = input$num_x, y = input$num_y, size = 6.5, colour = color)
  })

  output$ggplot <- renderPlot({
    board + add_tile
  })
}
