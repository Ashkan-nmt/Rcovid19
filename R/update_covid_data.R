#' @title update_covid_data
#' @description provides a function to download the latest Corona Virus data from Johns Hopkins University
#' @return a data-frame with this variables: country, date, death_num, confirmed_num, recovered_num
#' @export
#' @import tidyr
#' @import dplyr
#' @examples
#' data <- update_covid_data()
update_covid_data <- function(){
  library(tidyr)
  library(dplyr)

  confirmed <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") %>%
    gather(key = "date0",value = "confirmed_num0",-c("Province.State","Country.Region","Lat","Long")) %>%
    select(country=Country.Region , date0,confirmed_num0) %>%
    group_by(country,date0) %>%
    summarise(confirmed_num = sum(confirmed_num0)) %>%
    ungroup() %>%
    separate(date0,c(NA,"date1"),sep = "X") %>%
    separate(date1,c("m","d","y")) %>%
    mutate(y2=as.character(as.integer(y)+2000)) %>%
    mutate(date=as.Date(paste0(y2,"-",m,"-",d))) %>%
    select(country,date,confirmed_num) %>%
    arrange(country,date)

  death <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv") %>%
    gather(key = "date0",value = "death_num0",-c("Province.State","Country.Region","Lat","Long")) %>%
    select(country=Country.Region , date0,death_num0) %>%
    group_by(country,date0) %>%
    summarise(death_num = sum(death_num0)) %>%
    ungroup() %>%
    separate(date0,c(NA,"date1"),sep = "X") %>%
    separate(date1,c("m","d","y")) %>%
    mutate(y2=as.character(as.integer(y)+2000)) %>%
    mutate(date=as.Date(paste0(y2,"-",m,"-",d))) %>%
    select(country,date,death_num) %>%
    arrange(country,date)

  recovered <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv") %>%
    gather(key = "date0",value = "recovered_num0",-c("Province.State","Country.Region","Lat","Long")) %>%
    select(country=Country.Region , date0,recovered_num0) %>%
    group_by(country,date0) %>%
    summarise(recovered_num = sum(recovered_num0)) %>%
    ungroup() %>%
    separate(date0,c(NA,"date1"),sep = "X") %>%
    separate(date1,c("m","d","y")) %>%
    mutate(y2=as.character(as.integer(y)+2000)) %>%
    mutate(date=as.Date(paste0(y2,"-",m,"-",d))) %>%
    select(country,date,recovered_num) %>%
    arrange(country,date)
  allData <- confirmed %>%
    inner_join(death,by=c("country","date")) %>%
    inner_join(recovered,by=c("country","date"))

  return(allData)
}

