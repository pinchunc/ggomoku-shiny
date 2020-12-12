server <- function(input, output) {
  
  board_size <- default_board_size
  
  # initialize the move history data.frame
  message("Initializing reactive data.frame...")
  values <- reactiveValues(df = data.frame(x = numeric(),
                                           y = numeric(),
                                           move_color = character()))

  
  
  
  newEntry <- observeEvent(input$goButton, {
    
    # if the move is odd, it is 'black', otherwise white
    if (as.numeric(input$goButton) %in% seq(1, 119, 2)) {
      color <- "black"
    }
    else {
      color <- "white"
    }
    
    message("Adding move to move history...")
    # creating the new row based on user input
    new_row <- data.frame(x = as.numeric(input$x_coord), 
                          y = as.numeric(input$y_coord), 
                          move_color = color)

    values$df <- rbind(values$df, new_row)
    
    
  })
  
  dataInput <- reactive({
    values$df
  })
  
  message("Calling renderGirafe...")
  output$plot <- renderGirafe({
    
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
  
  message("Calling renderDataTable...")
  output$table <- DT::renderDataTable({
    
    # Checks for duplicate moves
    if (input$goButton > 0) {
      validate(
        check_valid_move(x_input = input$x_coord, 
                         y_input = input$y_coord,
                         df = values$df)
      )
    }
    
    # Printing the move history data.frame
    dataInput()
  })
  
  observeEvent(input$goButton, {
      message("Initializing the matrix...")
      # initializing matrix
      matrix <- matrix(nrow = board_size, ncol = board_size)
    
      # Adding the move to the matrix
      for (i in 1:nrow(values$df)) {
          message("Adding move to the matrix...")
          matrix[(board_size + 1) - values$df$y[i], values$df$x[i]] <- values$df$move_color[i]
      }
      
      # Checking winner
      message("Checking winner...")
      winner <- gomoku_victory(matrix)
      
      # Print winner in console if it exists (change to renderUI)
      if (!is.na(winner)) {
        # Sound effect for winner
        # beepr::beep(sound = 3, expr = NULL)
        message("The winner is ", winner, "!")
        output$winner <- renderText({paste0("The winner is ", winner, "! Press the restart button to refresh the game.")})
      }
  })
  
  observeEvent(input$resetButton, {js$reset()}) 

}
