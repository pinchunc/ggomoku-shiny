ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # *Input
      numericInput(inputId = "num_x", label = "Choose a number for x coordinate",
                   value = 1, min = 1, max = board_size),
      numericInput(inputId = "num_y", label = "Choose a number for y coordinate",
                   value = 1, min = 1, max = board_size),
      actionButton(inputId = "clicks", 
                   label = "Click me")
    ),
    
    mainPanel(
      # *Output
      plotOutput("ggplot")
    )
  )
)