server <- function(input, output) {
  dataInput <- reactive({ 
    rbind(data.frame(x = numeric(), y = numeric()),
          data.frame(x = as.numeric(input$x_coord), y = as.numeric(input$y_coord)))
  })  

  output$plot <- renderGirafe({
    df <- data.frame(x = numeric(),
                           y = numeric())
    newdata <- dataInput()
    df <- rbind(df, newdata)
    board <- gomoku_board()
    add_tiles(df, board , "black")
    })
}
