ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("century", "Centuries", 
                         choices = c("1500s","1600s","1700s","1800s"))
    ), 
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", leafletOutput("plot")), 
                  tabPanel("Map", plotlyOutput("map"))
      )
    )
  )
)