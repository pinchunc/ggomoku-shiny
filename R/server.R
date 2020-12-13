server <- function(input, output) {
  board_size <- default_board_size
  # initialize the move history data.frame
  values <- reactiveValues()
  
  values$df <- data.frame(
    x = numeric(),
    y = numeric(),
    move_color = character(),
    move_number = numeric(),
    text_color = character()
  )
  
  # initializing matrix
  values$matrix <- matrix(nrow = board_size, ncol = board_size)
  
  # A reactive data.frame of the user input
  move_to_check <- reactive({
    data.frame(x = input$x_coord, y = input$y_coord)
  })

  # Disables the button if the move already has taken place
  button_allowed <- observe(
    if (nrow(merge(move_to_check(), (values$df %>% select(x, y)))) > 0) {
      disable("goButton")
    }
    else {
      enable("goButton")
    }
  )

  # Mentioning the first move's turn
  first_move <- observe(
    if (input$goButton == 0) {
      output$turn <- renderText({
        "It is black's turn to move."
      })
    }
  )
  
  newEntry <- observeEvent(input$goButton, {
    i <- as.numeric(input$goButton)
    # Ending the game if it reaches 120 moves
    if (i == 120) { 
      output$turn <- renderText({
        "The game ends in a stalemate!"
      })
      js$reset()
    }
    
    # if the move is odd, it is 'black', otherwise white
    if (i %in% seq(1, 119, 2)) {
      color <- "black"
      move_number <- (i + 1) / 2
      text_color <- "white"
    }
    else {
      color <- "white"
      move_number <- i / 2
      text_color <- "black"
    }

    # creating the new row based on user input
    new_row <- data.frame(
      x = as.numeric(input$x_coord),
      y = as.numeric(input$y_coord),
      move_color = color,
      move_number = move_number,
      text_color = text_color
    )
    values$df <- rbind(values$df, new_row)
    
    # add color to the matrix
    values$matrix[(board_size + 1) - values$df$y[i], values$df$x[i]] <- values$df$move_color[i]
    
    # Checking winner
    winner <- gomoku_victory(values$matrix)
    
    # Print winner in console if it exists
    # otherwise, announce whose turn it is.
    if (!is.na(winner)) {
      output$winner <- renderText({
        paste0("The winner is ", winner, "! Press the restart button to refresh the game.")
      })
    }
    else if (values$df$move_color[nrow(values$df)] == "black") {
      output$turn <- renderText({
        "It is white's turn to move."
      })
    }
    else if (values$df$move_color[nrow(values$df)] == "white") {
      output$turn <- renderText({
        "It is black's turn to move."
      })
    }
  })

  dataInput <- reactive({
    values$df
  })

  output$plot <- renderGirafe({
    # Initialize a new board
    board <- gomoku_board(board_size)

    # Adding points to the ggplot object
    board <- board +
      geom_point_interactive(
        data = dataInput(),
        aes(x = x, y = y, colour = move_color),
        size = 6.5) + 
      scale_colour_identity()

    # Adding move numbers to the plot if selected in the settings
    if (nrow(dataInput()) > 0 && input$show_moves == "Show move numbers") {
      board <- board + geom_text(
        data = dataInput(),
        aes(x = x, y = y, label = move_number, colour = text_color)
      )
    }
    # Plotting the board
    girafe(ggobj = board)
  })

  output$table <- DT::renderDataTable({
    # Printing the move history data.frame
    dataInput() %>% select(-text_color)
  })

  # Restarting the game if they click the reset button
  observeEvent(input$resetButton, {
    js$reset()
  })
}
