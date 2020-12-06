server <- function(input, output) {
  
  observeEvent(input$goButton, {
    message("Printing button index...")
    print(as.numeric(input$goButton))
    
  })
  
  message("Initializing reactive data.frame...")
  dataInput <- reactive({ 
    data.frame(x = as.numeric(input$x_coord), 
               y = as.numeric(input$y_coord))
  })  


  message("Calling renderGirafe...")
  
  output$plot <- renderGirafe({
    
    message("Updating the data.frame")
    newdata <- dataInput()
    df <- rbind(df, newdata)
    
    print(head(df))
    # If the button hasn't been pressed yet, initialize a new board
    if (input$goButton == 0) {
      board <- gomoku_board()
    }
    
    # Plot new board (returns girafe object)
    plot_new_board(df, board, "black")
  })

}
