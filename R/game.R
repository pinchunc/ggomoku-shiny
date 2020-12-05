gomoku_board <- function(board_size = 19) {
  
  # Initializing data.frame for board
  df <- data.frame(x = 1:board_size, y = 1:board_size)
  
  # Plotting the initial board
  # Drawing board
  board <- suppressMessages(
    print(
      ggplot(df) +
        geom_point(aes(x, y), size = 5, alpha = 0) +
        theme(
          aspect.ratio = 1,
          axis.ticks = element_line(colour = "black", size = 1),
          panel.grid.major = element_line(colour = "black"),
          panel.grid.minor = element_line(size = 1, colour = "black"),
          panel.background = element_rect(fill = "#D2B48C"),
          panel.ontop = FALSE
        ) +
        scale_x_continuous(
          breaks = seq(1, nrow(df), by = 1),
          minor_breaks = seq(1, nrow(df), 1)
        ) +
        scale_y_continuous(
          breaks = seq(1, nrow(df), by = 1),
          minor_breaks = seq(1, nrow(df), 1)
        ) +
        scale_x_continuous(
          breaks = seq(1, nrow(df), by = 1),
          minor_breaks = seq(1, nrow(df), 1),
          sec.axis = dup_axis()
        ) +
        scale_y_continuous(
          breaks = seq(1, nrow(df), by = 1),
          minor_breaks = seq(1, nrow(df), 1),
          sec.axis = dup_axis()
        )
    )
  )
  
  # Plotting the board
  return(board)
}

gomoku_victory <- function(matrix) {
  
  # Pull out a column or a row from the matrix as a vector
  winner <- NA
  
  # checking for winner on rows
  if (is.na(winner)) {
    rows_num <- split(matrix, row(matrix))
    rows_rle <- lapply(rows_num, FUN = rle)
    winner_list <- purrr::map(rows_rle, gomoku_winner)
    if (any(!is.na(winner_list))) {
      winner <- winner_list[!is.na(winner_list)]
    }
  }
  
  # checking for winner on columns
  if (is.na(winner)) {
    cols_num <- split(matrix, col(matrix))
    cols_rle <- lapply(cols_num, FUN = rle)
    winner_list <- purrr::map(cols_rle, gomoku_winner)
    if (any(!is.na(winner_list))) {
      winner <- winner_list[!is.na(winner_list)]
    }
  }
  
  # checking for winner on diagonals
  # split the matrix to get diagonals
  if (is.na(winner)) {
    d <- row(matrix) - col(matrix)
    diags_num <- split(matrix, d)
    diags_rle <- lapply(diags_num, FUN = rle)
    winner_list <- purrr::map(diags_rle, gomoku_winner)
    if (any(!is.na(winner_list))) {
      winner <- winner_list[!is.na(winner_list)]
    }
  }
  
  # split the matrix to get reverse diagonals
  if (is.na(winner)) {
    r <- row(matrix) + col(matrix)
    rev_diags_num <- split(matrix, r)
    rev_diags_rle <- lapply(rev_diags_num, FUN = rle)
    winner_list <- purrr::map(rev_diags_rle, gomoku_winner)
    if (any(!is.na(winner_list))) {
      winner <- winner_list[!is.na(winner_list)]
    }
  }
  return(winner)
}

gomoku_winner <- function(rle_output) {
  if (5 %in% rle_output$lengths) {
    winner_list <- rle_output$values[which(rle_output$lengths == 5)]}
  else {winner_list <- NA}
  return(winner_list)
}

# 
# #board <- gomoku_board()
# add_tiles <- function(x_coord, y_coord, board, color) {
#   require(ggplot2)
#   require(ggiraph)
#   board <- board +
#     geom_point_interactive(aes(x = x_coord, y = y_coord),
#                            size = 6.5, colour = color)
# 
#   ggiraph(ggobj = board, width = 1, selection_type = "single")
# }

#xy_coord <- data.frame(x = c(3,8), y = c(4,8))




plot_new_board <- function(xy_coord, board) {
  require(ggplot2)
  require(ggiraph)
  board <- board +
    geom_point_interactive(data = xy_coord,
                           aes(x = x, y = y),
                           size = 6.5, color = xy_coord$move_color)
  girafe(ggobj = board)
}
  
# get_board_size <- function(board_size) { 
#   
#   }
# 
# create_state <- function(params) {
#   board_size <- board_size
#   state <- list(nextplayer = params$player_names[1],
#                 game_over = FALSE,
#                 params = params
#   )
#   state
# }
# 
# # Keep track of whose turn it is
# find_nextplayer <- function(state) {
#   current <- state$nextplayer
#   players <- state$params$player_names
#   next_idx <- which(players == current) + 1
#   next_idx <- replace(next_idx, next_idx > length(players), 1) # In case there's just 1 player
#   players[next_idx]
# }
# 
# plot_state <- function(state) {
#   colors <- c("#7CAE00", "#00BFC4", "#F8766D")
#   names(colors) <- c("You", "Computer", "None")
#   
#   consumers <- state$consumers %>%
#     mutate(
#       tip = paste0(count, " consumers with preference: ", LETTERS[xcor], "\n",
#                    "Distance to closest product: ", distance_bought, "\n",
#                    "Last bought from: ", last_bought
#       )
#     )
#   
#   
#   mark_moves <- mutate(state$legal_moves, tip = paste0("Cost: ", cost))
#   
#   g <- ggplot(df) +
#     geom_point(aes(x, y), size = 5, alpha = 0) +
#     theme(
#       aspect.ratio = 1,
#       axis.ticks = element_line(colour = "black", size = 1),
#       panel.grid.major = element_line(colour = "black"),
#       panel.grid.minor = element_line(size = 1, colour = "black"),
#       panel.background = element_rect(fill = "#D2B48C"),
#       panel.ontop = FALSE
#     ) +
#     scale_x_continuous(
#       breaks = seq(1, nrow(df), by = 1),
#       minor_breaks = seq(1, nrow(df), 1)
#     ) +
#     scale_y_continuous(
#       breaks = seq(1, nrow(df), by = 1),
#       minor_breaks = seq(1, nrow(df), 1)
#     ) +
#     scale_x_continuous(
#       breaks = seq(1, nrow(df), by = 1),
#       minor_breaks = seq(1, nrow(df), 1),
#       sec.axis = dup_axis()
#     ) +
#     scale_y_continuous(
#       breaks = seq(1, nrow(df), by = 1),
#       minor_breaks = seq(1, nrow(df), 1),
#       sec.axis = dup_axis()
#     )
#   
#   ggiraph(ggobj = g, width = 1, selection_type = "single")
# }
# 
# # Create parameters
# create_params <- function(players, board_size) {
#   
#   if (!is.null(players)) {
#     stopifnot(is.character(players))
#   }
#   
#   params <- list(
#     player_names = players,
#     max_xcor = board_size,
#     max_ycor = board_size,
#   )
#   
#   params
# }
# 
# # Set up the game
# # 
default_board_size <- 19
# params <- create_params(
#   players = c("Black", "White"),
#   board_size = default_board_size
# )
# state <- create_state(params)

