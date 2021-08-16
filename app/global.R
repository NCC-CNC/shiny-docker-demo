# Print information for example logging
message("")
message(cli::rule())
message("Initializing application")
message(Sys.time())
message(cli::rule())
message("")

# load dependencies
library(shiny)
library(dplyr)
library(rhandsontable)
library(sp)
library(leaflet)
library(leafpop)
