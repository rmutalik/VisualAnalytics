# Please note that there is missing data for many of the voyages, where this database only contains details for approximately 5 million enslaved Africans who arrived alive at the final port. Many slaves died in transport, or the details around the slave voyage were not fully recorded.

### Load datasets
slave_routes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-16/slave_routes.csv')
world_cities <- readr::read_csv('./data/worldcities.csv')
origin_countries <- readr::read_csv('./data/slave_origin_countries.csv')

### Clean datasets
slave_routes[] <- lapply(slave_routes, gsub, pattern='Africa.', replacement='Africa')
world_cities <- world_cities[,c(1,3:5)]
origin_countries <- origin_countries %>% 
  mutate(country = replace(country, country == 'England', 'United Kingdom')) %>% 
  mutate(country = replace(country, country == 'Other Africa', 'Africa')) %>% 
  mutate(country = replace(country, country == 'Other Brazil', 'Brazil')) %>%
  mutate(country = replace(country, country == 'Northern Germany', 'Germany'))

### Add century column
str(slave_routes)
century <- as.numeric(slave_routes$year_arrival) %/% 100
century <- century * 100
slave_routes$century <- century

### Join datasets
origin_cities <- merge(x=world_cities, y=origin_countries, by="country")
geo_ports <- merge(x=slave_routes, y=origin_cities,by.x="port_origin",by.y="city",all.x=TRUE)

write.csv(geo_ports, "./data/geo_ports.csv")
