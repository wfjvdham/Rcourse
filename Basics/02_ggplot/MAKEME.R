# Load the tidyverse package so you can use the ggplot package

# install the nycflights package

# Load the nycflights13 library

# Run the next line and check that a flights data frame loads in your 
# environment

flights <- as_tibble(flights) %>%
  sample_n(10000)

# Show in a graph the distribution of the distances of the flights

# Show in a graph number of flights per origin

# Show in a graph the relationship between dep_time and arr_time

# Show in a graph the relationship between dep_delay and origin

# Show in a graph the relationship between month and origin

# Show in a graph the relationship between arr_delay and dep_delay
# using cut()

# Show in a graph the relationship between air_time, distance and origin
# NOTE it will be difficult to conclude something from this graph

# Show in a graph the relationship between air_time, distance and dep_delay
# NOTE it will be difficult to conclude something from this graph
