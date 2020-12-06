

server <- function(input, output) {
  
  # observeEvent(input$goButton, {
  #   message("Printing button index...")
  #   print(as.numeric(input$goButton))
  #   
  # })
  
  values <- reactiveValues()
  values$df <- data.frame(x = numeric(),
                          y = numeric())
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
  
  message("Initializing reactive data.frame...")
  # dataInput <- eventReactive(input$goButton, {
  #     isolate(df[nrow(df) + 1,] <- c(input$x_coord, input$y_coord))
  # })
  #output$table <- renderTable({df})
  #Initial Dataframe
  # df <- data.frame(x = numeric(),
  #                  y = numeric())
  # dataInput <- eventReactive(input$goButton,{ 
  #   df <- rbind(df, data.frame(x = as.numeric(input$x_coord), 
  #                              y = as.numeric(input$y_coord)))
  #   return(df)
  # })
  
  message("Calling renderGirafe...")
  output$plot <- renderGirafe({
    
    message("Updating the data.frame")
    # newdata <- dataInput()
    # print(newdata)
    # df <- rbind(df, newdata)
    print(dataInput())
    # If the button hasn't been pressed yet, initialize a new board
    if (input$goButton == 0) {
      board <- gomoku_board()
    }
    
    # Plot new board (returns girafe object)
    plot_new_board(dataInput(), board, "black")
  })

}
