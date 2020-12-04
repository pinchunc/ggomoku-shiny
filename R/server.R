server <- function(input, output) {
  #print out the iteration
  # observeEvent(input$clicks, {
  #   print(as.numeric(input$clicks))
  # })
  reac <- reactiveValues()
  
  observe({ 
    #reac$x_coord =  input$x_coord
    #reac$y_coord = input$y_coord
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
  output$game <- renderGirafe({add_tiles(testdata, board , "black")})
}
