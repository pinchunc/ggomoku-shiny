server <- function(input, output) {
  # print out the iteration
  # observeEvent(input$clicks, {
  #   print(as.numeric(input$clicks))
  # })
  dataInput <- reactive({
    testdata <- data.frame(
      "x" = numeric(),
      "y" = numeric()
    )
    testdata <- rbind(
      testdata,
      data.frame("x" = as.numeric(input$x_coord), "y" = as.numeric(input$y_coord))
    )
  })

  # create input data frame
  # testdata <- data.frame("x" = "x",
  #                        "y" = "y")
  # finaldata = eventReactive(input$action, {
  #   testdata = rbind(testdata,
  #                    data.frame("x" = input$x_coord, "y" = input$y_coord))
  # })
  # print({testdata})

  # Adds piece to the plotted grid
  # board <- gomoku_board()
  output$game <- renderGirafe({

    # input$submit is the number of times "submit" was clicked AKA move number
    df_coord <- data.frame(move_num = numeric(),
                           x = numeric(),
                           y = numeric(),
                           color = character()
                           )
    
    isolate({
      
      if (input$submit %in% seq(1, 119, 2)) {
        color <- "black"
      }
      else {
        color <- "white"
      }
      # if the move number is odd, it's "black", else white


      # data frame of 120 potential moves
      rbind(df_coord, c(input$submit, 
                        input$x_coord, 
                        input$y_coord, 
                        color))

      df_coord
    })

    # to prevent the plot from appearing before the button has been clicked
    # theoretically this is supposed to prevent the first move from being placed
    # before the button has been clicked

    if (input$submit == 0) {
     return()
    }

    # What is dataInput()?
    # add_tiles(dataInput(), board, "black")

    add_tiles(
      xy_coord = df_coord,
      board = board)
  })
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
