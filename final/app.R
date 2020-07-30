library(shiny)
library(leaflet)
library(dplyr)

source('geo_data.R')

df <- read.csv('data/geo_ports.csv')

# Define UI for application that filters map points based on year and minimum population
ui <- fluidPage(
    
    # Application title
    titlePanel("Atlantic Slave Trade Over Time"),
    
    # Sidebar with a slider input for year, numeric input for population 
    sidebarLayout(
        sidebarPanel(
            selectInput('year', "Year", choices = c(1500,1600,1700,1800))
        ),
        
        # Show the map and table
        mainPanel(
            leafletOutput("map"),
            dataTableOutput("table")
        )
    )
)

# Define server logic required to draw a map and table
server <- function(input, output) {
    
    output$map <- renderLeaflet({
        
        pop_by_year <- filter(df, 
                              year_arrival == input$year)
        
        leaflet(data = pop_by_year) %>%
            addTiles() %>%
            addMarkers(~lng, ~lat)
    })
    
    output$table <- renderDataTable({

        pop_by_year <- filter(df,
                              year_arrival == input$year)
        pop_by_year

    })
}

# Run the application 
shinyApp(ui = ui, server = server)
