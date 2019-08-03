# Load the tidyverse package so you can use the ggplot package

# Load the nycflights13 library

# Run the next line and check that a flights data frame loads in your 
# environment

flights <- as_tibble(flights) %>%
  sample_n(10000)

# Select the columns dep_time, sched_dep_time, dep_delay, arr_time, sched_arr_time

# How many flights are there on 1^th January 2013?

# What is the largest distance (in km! (miles x 1.6)) between two airports? 
# Also give the names of the airports.

# How many different destinations are there?

# Which destination has the fewest flights?
  
# What is the median of the distance of all the flights with carrier `DL`?

# Which destination had the most flights in January 2013?

# What is the median distance and air_time per carrier

# What is the average dep_delay of all flights

# What is the percentage of late flights per origin

# Define 3 types of flights short: distance < 500, medium: distance < 1000,
# long: the rest. Calculate the average airtime per flight type
