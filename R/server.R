server <- function(input, output) {

  # Adds piece to the plotted grid
  output$game <- renderGirafe({
    input$submit
    
    dist <- isolate(add_tiles(input$x_coord,  input$y_coord,  board , "black"))
    

  })
}
