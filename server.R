server <- function(input, output) {
  output$ggplot <- renderPlot({
    gomoku_board()
  })
  
  #print out the iteration
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
}