server <- function(input, output) {
  # print out the iteration
  # observeEvent(input$clicks, {
  #   print(as.numeric(input$clicks))
  # })
  #  dataInput <- reactive({
  #    testdata <- data.frame(
  #      "x" = numeric(),
  #      "y" = numeric()
  #
  #   testdata <- rbind(
  #      testdata,
  #      data.frame("x" = as.numeric(input$x_coord), "y" = as.numeric(input$y_coord))
  #    )
  #  })

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
  # 

  

  
  # when pressing the button, add a new row to the data.frame

  # reactive() is for calculating values, without side effects
  # observe() is for performing actions, with side effects

  
  globals <- reactiveValues(
    data = data.frame(move_num = numeric(),
                      move_color = character(),
                      x = numeric(),
                      y = numeric()
                      )
    )
  
  observeEvent(input$goButton, {
  
     if (input$goButton %in% seq(1, 119, 2)) {
       color <- "black"
     }
     else {
       color <- "white"
     }
     
     globals$data <- globals$data %>% add_row(move_num = input$goButton,
                                                  move_color = color,
                                                  x = input$x_coord,
                                                  y = input$y_coord)
     
     })
  
  output$plot <- renderGirafe({

    # What is dataInput()?
    # add_tiles(dataInput(), board, "black")

    message("Adding new tiles...")
    add_tiles(
        xy_coord = data,
        board = board
      )
  })

}
