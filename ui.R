ui <- fluidPage(
  titlePanel("Play Gomoku (Five in a Row)"),
  helpText("Try to get five tiles of your own color in a row either horizontally, vertically, or diagonally, before your opponent."),
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
    tabsetPanel(
      id = "tabs",
      tabPanel(
        title = "Game",
        column(
          12, girafeOutput("stateplot", width = "100%", height = "650px"),
          tableOutput("move_history")
        ),
        icon = icon("gamepad")
      ),
      tabPanel(
        title = "How to play",
        strong("Background"),
        p("Gomoku (also known as Five in a Row) is a 2-player game where one player uses white tiles and the other uses black tiles. The game is played on a 15x15 or 19x19 squared board, similar to Go."),
        br(),
        p("Each player has 60 tiles that they take turns placing on the intersections of the grid. Each player's goal is to place an unbroken row of five tiles of their own color either horizontally, vertically, or diagonally."),
        br(),
        br(),
        strong("Rules"),
        p("Black goes first."),
        p("A tile of the same color cannot be added twice in a row."),
        p("A tile cannot replace an existing tile on the board."),
        p("The tile must be placed within the range of the board (a whole number between 1 and the board size)."),
        p("In keeping with 'standard' Gomoku, one must have exactly 5 tiles in a row to win, greater than 5 does not count."),
        br(),
        br(),
        strong("Optional ('house') Rules"),
        p("Players can opt to follow the following rules to make the game more fair, as Black has a significant advantage by virtue of being able to move first."),
        br(),
        p("The rule of three and three bans a move that simultaneously forms two open rows of three tiles i.e. two rows that are not blocked at either end."),
        p("The rule of four and four bans a move that simultaneously forms two rows of four open tiles (open or otherwise).")
      ),
      tabPanel(
        title = "Settings",
        radioButtons("show_moves", strong("Show moves?"),
          choices = c("Show moves on tiles", "Do not show moves on tiles"), inline = TRUE
        ),
        sliderInput("board_size", strong("Choose n where the board dimensions are nxn"),
          min = 15, max = 19, value = 19
        ),
      )
    )
  )
)
