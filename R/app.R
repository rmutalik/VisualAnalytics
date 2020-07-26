library(shiny)
library(plotly)
library(leaflet)
library(tidyverse)

# source("R/slavery.R")
# source("R/geoplot.R")
source("R/ui.R")
source("R/server.R")

geo_ports <- read_csv("data/geo_ports.csv")

shinyApp(ui, server)