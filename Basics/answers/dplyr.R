# Load the tidyverse package

library(tidyverse)

# Load the nycflights13 library

library(nycflights13)

# Run the next line and check that a flights data frame loads in your 
# environment

flights <- as_tibble(flights) %>%
  sample_n(10000)

# Use summary(). Install and load the skimr package. Use the skim() function.

summary(flights)

#install.packages(skimr)
library(skimr)
skim(flights)

# Select the columns dep_time, sched_dep_time, dep_delay, arr_time, sched_arr_time

flights %>%
  select(dep_time:arr_delay)

# How many flights are there on 1^th January 2013?

flights %>%
  filter(year == 2013, month == 1, day == 1) %>%
  nrow()

# What is the largest distance (in km! (miles x 1.6)) between two airports? 
# Also give the names of the airports.

flights %>%
  arrange(desc(distance)) %>%
  slice(1) %>%
  mutate(distance_km = distance * 1.60934) %>%
  select(distance_km, origin, dest)

# How many different destinations are there?

flights %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  nrow()

flights %>%
  count(dest) %>%
  nrow()

n_distinct(flights$dest)

# Which origin has the fewest flights?

flights %>%
  count(origin) %>%
  arrange(n) %>%
  slice(1)

# What is the median of the distance of all the flights with carrier `DL`?

flights %>%
  group_by(carrier) %>%
  summarise(medianDistance = median(distance)) %>%
  filter(carrier == "DL") %>%
  pull("medianDistance") 

# Which destination had the most flights in January 2013?

flights %>%
  filter(year == 2013 & month == 1) %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pull("dest")

# What is the median distance and air_time per carrier

flights %>%
  group_by(carrier) %>%
  summarise(
    median_distance = median(distance),
    median_air_time = median(air_time, na.rm = TRUE)
  ) %>%
  arrange(median_distance)

# What is the average dep_delay of all flights

flights %>%
  summarise(avg_dep_time = mean(dep_delay, na.rm = TRUE)) 

mean(flights$dep_delay, na.rm = TRUE)

# What is the percentage of flights that arrive late per origin

flights %>%
  mutate(is_late = arr_delay > 0) %>%
  group_by(origin) %>%
  summarise(
    n = n(),
    is_late = sum(is_late, na.rm = TRUE)
  ) %>%
  mutate(
    perc_is_late = is_late / sum(n) * 100
  )

# Define 3 types of flights short: distance < 500, medium: distance < 1000,
# long: the rest. Calculate the average airtime per flight type

flights %>%
  mutate(flight_type = case_when(
    distance < 500 ~ "short",
    distance < 1000 ~ "medium",
    TRUE ~ "long"
  )) %>%
  group_by(flight_type) %>%
  summarise(avg_air_time = mean(air_time, na.rm = TRUE))
