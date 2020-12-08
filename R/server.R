server <- function(input, output) {
  message("Initializing reactive data.frame...")
  values <- reactiveValues(df = data.frame(x = numeric(),
                                                   y = numeric()))
  
  newEntry <- observeEvent(input$goButton, {
    message("Printing button index...")
    print(as.numeric(input$goButton))
    values$df <- rbind(values$df,
                       data.frame(x = as.numeric(input$x_coord), 
                                  y = as.numeric(input$y_coord)))
  })
  
  dataInput <- reactive({
    values$df
  })
  

  message("Calling renderGirafe...")
  output$plot <- renderGirafe({
    
    message("Updating the data.frame")
    print(dataInput())
    # If the button hasn't been pressed yet, initialize a new board
    if (input$goButton == 0) {
      board <- gomoku_board()
    }
    
    # Plot new board (returns girafe object)
    plot_new_board(dataInput(), board, "black")
  })

}
