#' @title covid_country_plot
#' @description provides a function to draw 2-d plot for a country death and confirmed covid data, based on Johns Hopkins University's information
#' @param country a string of country name that start with capital case
#' @param start_date beginning of time interval : "yyyy-mm-dd"
#' @param end_date end of time interval : "yyyy-mm-dd"
#' @return a 2-d plot
#' @export
#' @import ggplot2
#' @import dplyr
#' @examples
#' covid_country_plot("Iran","2020-03-24","2020-08-17")
covid_country_plot <- function(country, start_date, end_date){
  library(ggplot2)
  library(tidyr)
  library(dplyr)

  country0 <- country
  data <- update_covid_data() %>%
    filter(country==country0 & date>=start_date & date<=end_date)

  ggplot(data, aes(x=date))+
    geom_line(aes(y=death_num,color="red"),size=1)+
    geom_line(aes(y=confirmed_num,color="black"),size=1)+
    scale_color_discrete(name ="", labels = c("Confirmed","Death"))+
    ylab("Count")+
    ggtitle(country0)+
    theme_bw()
}
