server <- function(input, output) {
  output$ggplot <- renderPlot({
    gomoku_board()
  })
  
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  # Adds piece to the plotted grid
  add_tile <- reactive({annotate("point", x = input$num_x, y = input$num_y, size = 6.5, colour = color)
  })
  
}
