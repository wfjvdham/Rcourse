# Load the tidyverse package so you can use the ggplot package

library(tidyverse)

# install the nycflights package

# install.packages("nycflights13")

# Load the nycflights13 library

library(nycflights13)

# Run the next line and check that a flights data frame loads in your 
# environment

flights <- as_tibble(flights) %>%
  sample_n(10000)

# Show in a graph the distribution of the distances of the flights

ggplot(flights) +
  geom_histogram(aes(distance), binwidth = 100)

# Show in a graph number of flights per origin

ggplot(flights) +
  geom_bar(aes(origin))

# Show in a graph the relationship between dep_time and arr_time

ggplot(flights) +
  geom_point(aes(dep_time, arr_time))

# Show in a graph the relationship between dep_delay and origin

ggplot(flights) +
  geom_boxplot(aes(origin, dep_delay)) + 
  coord_cartesian(ylim = c(-50, 100))

# Show in a graph the relationship between month and origin

ggplot(flights) +
  geom_bar(aes(factor(month), fill = origin), position = "dodge")

# Show in a graph the relationship between arr_delay and dep_delay
# using cut()

ggplot(flights) +
  geom_boxplot(aes(cut(dep_delay, 5), arr_delay))

# Show in a graph the relationship between air_time, distance and origin
# NOTE it will be difficult to conclude something from this graph

ggplot(flights) +
  geom_point(aes(distance, air_time, color = origin))

# Show in a graph the relationship between air_time, distance and dep_delay
# NOTE it will be difficult to conclude something from this graph

ggplot(flights) +
  geom_point(aes(distance, air_time, color = hour))
