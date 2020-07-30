library(shiny)
library(leaflet)
library(spData)
library(dplyr)

df <- read.csv('C:\\Users\\Ajay\\Desktop\\School\\DSBA 5122\\VisualAnalytics-master\\data\\geo_ports.csv')

# Define UI for application that filters map points based on year and minimum population
ui <- fluidPage(
    
    # Application title
    titlePanel("Atlantic Slave Trade Over Time"),
    
    # Sidebar with a slider input for year, numeric input for population 
    sidebarLayout(
        sidebarPanel(
            
            # sliderInput("year_arrival",
            #             "Year",
            #             min = 1500,
            #             max = 1900,
            #             step = 5,
            #             sep = "",
            #             value = 1500)
            selectInput('year', "Year", choices = c(1500,1600,1700,1800))
            
            # numericInput("n_slaves_arrival",
            #              "Minimum Population (in millions)",
            #              min = 1,
            #              max = 20,
            #              value = 10)
        ),
        
        # Show the map and table
        mainPanel(
            # plotOutput("distPlot"),
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
                            
                              # n_slaves_arrived > input$n_slaves_arrived)
        
        leaflet(data = pop_by_year) %>%
            addTiles() %>%
            addMarkers(~lng, ~lat)
    })
    
    output$table <- renderDataTable({

        pop_by_year <- filter(df,
                              year_arrival == input$year)
                              # n_slaves_arrived > input$n_slaves_arrived)

        pop_by_year

    })
}

# Run the application 
shinyApp(ui = ui, server = server)
