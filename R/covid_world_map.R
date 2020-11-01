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
