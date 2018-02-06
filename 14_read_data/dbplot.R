library(tidyverse)
library(nycflights13)
# plotting package
# httr::set_config( httr::config( ssl_verifypeer = 0L ) )
# devtools::install_github("edgararuiz/dbplot")
library(dbplot)

flights <- as_data_frame(flights)

ggplot(flights) +
  geom_histogram(aes(sched_dep_time))

flights %>% 
  dbplot_histogram(sched_dep_time)

ggplot(flights) +
  geom_point(aes(arr_delay, dep_delay))

flights %>%
  filter(!is.na(arr_delay)) %>%
  dbplot_raster(arr_delay, dep_delay) 

flights %>%
  dbplot_bar(origin)

flights %>%
  dbplot_line(day)
