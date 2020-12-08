library(shiny)
library(shinyjs)
library(shinydashboard)
library(dplyr)
library(tibble)
library(purrr)
library(ggplot2)
library(ggiraph)
library(DT)
jsResetCode <- "shinyjs.reset = function() {history.go(0)}" # Define the js method that resets the page

# game.R needs to be loaded first
source("R/game.R")
source("R/ui.R")
source("R/server.R")

shinyApp(ui, server)
