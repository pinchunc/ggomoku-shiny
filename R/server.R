server <- function(input, output) {
  #print out the iteration
  # observeEvent(input$clicks, {
  #   print(as.numeric(input$clicks))
  # })
  dataInput <- reactive({ 
    testdata <- data.frame("x" = numeric(),
                           "y" = numeric())
    testdata = rbind(testdata,
                     data.frame("x" = as.numeric(input$x_coord), "y" = as.numeric(input$y_coord)))
  })  

  #create input data frame
  # testdata <- data.frame("x" = "x",
  #                        "y" = "y")
  # finaldata = eventReactive(input$action, {
  #   testdata = rbind(testdata,
  #                    data.frame("x" = input$x_coord, "y" = input$y_coord))
  # })
  # print({testdata})
  
  # Adds piece to the plotted grid
  #board <- gomoku_board()
  output$game <- renderGirafe({add_tiles(dataInput(), board , "black")})
  # Adds piece to the plotted grid
  
  # output$game <- renderGirafe({
  #   # depends on the actionButton with input_id = "submit"
  #   input$submit
  #   
  #   # Adding isolate() to avoid dependency
  #   dist <- isolate(add_tiles(input$x_coord, input$y_coord, board, "black"))
  #   
  # 
  # })
}
