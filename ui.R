ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("Play Gomoku (Five in a Row)"),
  helpText("Try to get five tiles of your own color in a row either horizontally, vertically, or diagonally, before your opponent."),
  hr(),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "show_moves", label = strong("Show move numbers on tiles?"),
        choices = c("Do not show move numbers", "Show move numbers"),
      ),
      br(),
      br(),
      title = "Make Your Move",
      textOutput(outputId = "turn"),
      tags$head(tags$style("#turn{font-size: 15px; font-style: bold;}")),
      # *Input
      sliderInput(
        inputId = "x_coord", label = "Choose a number for x coordinate",
        value = 10, min = 1, max = default_board_size
      ),
      sliderInput(
        inputId = "y_coord", label = "Choose a number for y coordinate",
        value = 10, min = 1, max = default_board_size
      ),
      actionButton(inputId = "goButton", label = "Submit Move", class = "btn-success"
      ),                                           
      # Include shinyjs in the UI
      shinyjs::extendShinyjs(text = "shinyjs.reset = function() {history.go(0)}", functions = "reset"), # Add the js code to the page
      actionButton(inputId = "resetButton", label = "Restart")
    ),
    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel(
          title = "Game",
          column(
            12, textOutput(outputId = "winner"),
            tags$head(tags$style("#winner{font-size: 30px;
                                 font-style: bold;
                                 }"
            )
            )
          ),
          column(
            12, ggiraph::girafeOutput(outputId = "plot", width = "100%", height = "500px"),
          ),
          icon = icon("gamepad"),
          br(),
          strong("Move History"),
          column(
            12, DT::dataTableOutput(outputId = "table")
          )
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
          title = "About",
          hr(),
          strong("Authors (Links to our personal websites)"),
          br(),
          tags$a(href="https://sites.uci.edu/pinchunchen/", "Pin-Chun Chen"),
          br(),
          tags$a(href="https://jstevenr.com", "J Steven Raquel"),
          br(),
          br(),
          p("For more information about the game, please check out the GitHub repositories!"),
          tags$a(href="https://github.com/pinchunc/ggomoku-shiny", "Respository for ggomoku Shiny app"),
          br(),
          tags$a(href="https://github.com/pinchunc/ggomoku", "Repository for ggomoku package"),
          br(),
          br(),
          p("Copyright (c) 2020 Pin-Chun Chen & J Steven Raquel"),
          icon = icon("address-card")
        )
      )
    )
  )
)
