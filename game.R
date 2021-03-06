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

default_board_size <- 19