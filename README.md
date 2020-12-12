# Background
Gomoku (also known as Five in a Row) is a 2-player game where one player uses white tiles and the other uses black tiles. As in standard Gomoku, this version of the game is played on a 19 x 19 board.

Each player has 60 tiles that they take turns placing on the intersections of the grid. Each player's goal is to place an unbroken row of five tiles of their own color either horizontally, vertically, or diagonally.

This Shiny app is an implementation of the `ggomoku` package designed by Pin-Chun Chen and J Steven Raquel, ported over to Shiny. It allows players to play the game of Gomoku within Shiny as opposed to R. 

# Rules
Black goes first.

A tile of the same color cannot be added twice in a row.

A tile cannot replace an existing tile on the board.

The tile must be placed within the range of the board (a whole number between 1 and the board size).

In keeping with 'standard' Gomoku, one must have exactly 5 tiles in a row to win, greater than 5 does not count.


# Optional ('house') Rules
Players can opt to follow the following rules to make the game more fair, as Black has a significant advantage by virtue of being able to move first.

The rule of three and three bans a move that simultaneously forms two open rows of three tiles i.e. two rows that are not blocked at either end.

The rule of four and four bans a move that simultaneously forms two rows of four open tiles (open or otherwise).