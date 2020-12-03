server <- function(input, output) {

  # Adds piece to the plotted grid
  output$game <- renderGirafe({
    # depends on the actionButton with input_id = "submit"
    input$submit
    
    # Adding isolate() to avoid dependency
    dist <- isolate(add_tiles(input$x_coord, input$y_coord, board, "black"))
    

  })
}
