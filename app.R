library(shiny)
library(shinyjs)
library(shinydashboard)
library(dplyr)
library(purrr)
library(ggplot2)
library(ggiraph)
library(DT)
jsResetCode <- "shinyjs.reset = function() {history.go(0)}" # Define the js method that resets the page

source("game.R")
source("ui.R")
source("server.R")

shinyApp(ui, server)

