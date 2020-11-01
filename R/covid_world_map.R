#' @title covid_world_map
#' @description provides a function to draw Covid-19 world map based on Johns Hopkins University's data
#' @param date a date string like "yyyy-mm-dd"
#' @param type should be equal to "death" or "confirmed"
#' @return a world map plot
#' @export
#' @import rworldmap
#' @import dplyr
#' @examples
#' covid_world_map("2020-03-24","death")
covid_world_map <- function(date , type){
  library(rworldmap)
  date0 <- date
  data <- update_covid_data()
  data2 <- data %>%
    select(country,date,death=death_num,confirmed=confirmed_num) %>%
    filter(date==date0)
  sPDF <- joinCountryData2Map(data2,joinCode = "NAME",nameJoinColumn = "country")
  mapCountryData(sPDF, nameColumnToPlot=type, mapTitle="Covid")
}
sticker(subplot = "C:/Users/ashkan/Desktop/coronavirus.jpg",
        s_y = 0.8, # Position of the sub plot (y)
        s_x = 1.0, # Position of the sub plot (x)
        s_width = .6, # Width of the sub plot
        s_height=0.01,
        package = "covid19", # Package name
        p_size = 15, # Font size of the text
        p_y = 1.5, # Position of the font (y)
        p_x = 1, # Position of the font (x)
        p_family = "incon", # Defines font
        # Spotlight
        spotlight = TRUE, # Enables spotlight
        l_y=0.8, # Position of spotlight (y)
        l_x=0.7, # Position of spotlight (x)
        # Sticker colors
        h_fill = "#5d8aa6", # Color for background
        h_color = "#2A5773", # Color for border
        dpi=300, # Resolution: Sets DPI
        filename="C:/Users/ashkan/Desktop/logo3.png")
