server <- function(input, output, session) {
  output$plot <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      setView(-30, 30, zoom = 2)
  })
  
  output$map <- renderPlotly({
    plot_geo(geo_ports, lat = ~lat, lon = ~lng) %>% 
      add_markers(
        text = ~paste(paste("Slaves: ", n_slaves_arrived)),
        hoverinfo = "text"
      )
  })
}