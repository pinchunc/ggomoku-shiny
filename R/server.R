server <- function(input, output) {
  
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
  
  # Adds piece to the plotted grid
  output$game <- renderGirafe({
    input$submit
    
    dist <- isolate(add_tiles(input$x_coord,  input$y_coord,  board , "black"))
    

  })
}
