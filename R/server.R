server <- function(input, output) {
  
  # initialize the move history data.frame
  message("Initializing reactive data.frame...")
  values <- reactiveValues(df = data.frame(x = numeric(),
                                           y = numeric(),
                                           move_color = character()))
  
  newEntry <- observeEvent(input$goButton, {
    message("Printing button index...")
    print(as.numeric(input$goButton))
    
    # if the move is odd, it is 'black', otherwise white
    if (as.numeric(input$goButton) %in% seq(1, 119, 2)) {
      color <- "black"
    }
    else {
      color <- "white"
    }
    
    # Adding new row to the move history data.frame
    values$df <- rbind(values$df,
                       data.frame(x = as.numeric(input$x_coord), 
                                  y = as.numeric(input$y_coord),
                                  move_color = color))
  })
  
  dataInput <- reactive({
    values$df
  })
  
  message("Calling renderGirafe...")
  output$plot <- renderGirafe({
    
    message("Updating the data.frame")
    print(dataInput())
    print(matrix)
  
    # If the button hasn't been pressed yet, initialize a new board
    if (input$board_size == "19x19") {
      board_size <- default_board_size
      board <- gomoku_board(board_size)
    }
    else if (input$board_size == "15x15") {
      board_size <- 15
      board <- gomoku_board(board_size)
    }
    
    
    # Show move numbers if show_moves is selected
    
    # Plot new board (returns girafe object)
    plot_new_board(dataInput(), board)
  })
  
  output$table <- DT::renderDataTable({
    # Printing the move history data.frame
    df_moves <- dataInput()
    df_moves
  })
  
  isolate({
    if (input$goButton > 0){
      message("initialize the matrix")
      matrix <- data.frame(matrix(nrow = board_size, ncol = board_size))
      for (i in 1:nrow(values$df)) {
          message("adding color to the matrix")
          matrix[(board_size + 1) - values$df$y[i], values$df$x[i]] <- values$df$move_color[i]
      }
    }
  })

}
