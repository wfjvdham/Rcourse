library(tidyverse)

pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)

pew <- pew %>%
  gather(2:11, key = "income", value = "count")

weather <- read.delim(
  file = "http://stat405.had.co.nz/data/weather.txt",
  stringsAsFactors = FALSE
)

weather <- weather %>%
  gather(d1:d31, key = "day", value = "temperature")

weather <- weather %>%
  spread(key = "element", value = "temperature")
