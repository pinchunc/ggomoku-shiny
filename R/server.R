server <- function(input, output) {
  
  observeEvent(input$goButton, {
    message("Printing button index...")
    print(as.numeric(input$goButton))
    
  })
  
  message("Initializing reactive data.frame...")
  dataInput <- reactive({ 
    rbind(data.frame(x = numeric(), 
                     y = numeric()),
          data.frame(x = as.numeric(input$x_coord), 
                     y = as.numeric(input$y_coord))
          )
  })  

  message("Calling renderGirafe...")
  output$plot <- renderGirafe({
    
    message("Updating the data.frame")
    df <- data.frame(x = numeric(),
                     y = numeric())
    newdata <- dataInput()
    df <- rbind(df, newdata)
    
    if (input$goButton == 0) {
      board <- gomoku_board()
    }
    
    plot_new_board(df, board, "black")
  })

}