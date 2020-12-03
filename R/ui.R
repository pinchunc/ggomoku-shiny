ui <- fluidPage(
  titlePanel("Play Gomoku (Five in a Row)"),
  helpText("Try to get five tiles of your own color in a row either horizontally, vertically, or diagonally, before your opponent."),
  hr(),
  sidebarLayout(
    sidebarPanel(
      # *Input
      sliderInput(
        inputId = "x_coord", label = "Choose a number for x coordinate",
        value = 10, min = 1, max = board_size
      ),
      sliderInput(
        inputId = "y_coord", label = "Choose a number for y coordinate",
        value = 10, min = 1, max = board_size
      ),
      actionButton(inputId = "submit", label = "Submit Move", class = "btn-success"
      )
    ),
    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel(
          title = "Game",
          column(
            12, girafeOutput(outputId = "game", width = "100%", height = "650px"),
          ),
          icon = icon("gamepad"),
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
          p("The rule of four and four bans a move that simultaneously forms two rows of four open tiles (open or otherwise)."),
          icon = icon("chess-board")
        ),
        tabPanel(
          title = "Settings",
          selectInput(
            inputId = "show_moves", label = strong("Show moves?"),
            choices = c("Show moves on tiles", "Do not show moves on tiles"),
          ),
          sliderInput(
            inputId = "board_size", label = strong("Choose the size of the board between 15x15 and 19x19 (default)"),
            min = 15, max = 19, value = default_board_size,
          ),
          icon = icon("wrench")
        ),
        tabPanel(
          title = "About",
          hr(),
          strong("Authors"),
          p("Pin-Chun Chen and J Steven Raquel"),
          p("UC Irvine Department of Statistics"),
          icon = icon("address-card")
        )
      )
    )
  )
)
