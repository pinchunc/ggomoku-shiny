server <- function(input, output) {

  board_size <- default_board_size
  # initialize the move history data.frame
  message("Initializing reactive data.frame...")
  values <- reactiveValues(df = data.frame(
    x = numeric(),
    y = numeric(),
    move_color = character()
  ))

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
    if(input$goButton == 0) {
      output$turn <- renderText({
        "It is black's turn to move."
      })
    }
  )

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
    new_row <- data.frame(
      x = as.numeric(input$x_coord),
      y = as.numeric(input$y_coord),
      move_color = color
    )

    values$df <- rbind(values$df, new_row)
  })

  dataInput <- reactive({
    values$df
  })

  message("Calling renderGirafe...")
  output$plot <- renderGirafe({

    # Initialize a new board
    board <- gomoku_board(board_size)

    # Show move numbers if show_moves is selected
    
    # Plot new board (returns girafe object)
    message("Plotting new board...")
    plot_new_board(dataInput(), board)
  })

  message("Calling renderDataTable...")
  output$table <- DT::renderDataTable({
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
    # otherwise, announce whose turn it is.
    
    if (!is.na(winner)) {
      # Sound effect for winner
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

  observeEvent(input$resetButton, {
    js$reset()
  })
}
