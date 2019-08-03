# Load the tidyverse package

library(tidyverse)

# Load the gapminder library (install if required)

library(gapminder)

# Run the next line and check that a gapminer data frame loads in your 
# environment

gapminder <- as_tibble(gapminder)

# Make a plot that shows the relationship between lifeExp, 
# pop and continent in 1957

gapminder %>%
  filter(year == 1957) %>%
  ggplot() +
  geom_point(aes(pop, lifeExp, color = continent))

# Show the population growth on earth over time.
# NOTE first convert the pop to milions, otherwise you get an error

gapminder %>%
  group_by(year) %>%
  summarise(total_pop_mlj = sum(pop / 1000000)) %>%
  ggplot() +
  geom_bar(aes(year, total_pop_mlj), stat = "identity") 

# Show in a graph for the 10 countries with the highes pop 
# for every country the percentage of the world population 
# that is living there in 2007

gapminder %>%
  filter(year == 2007) %>%
  mutate(pop_mlj = pop / 1000000) %>%
  mutate(perc = pop_mlj / sum(pop_mlj)) %>%
  arrange(desc(perc)) %>%
  slice(1:10) %>%
  ggplot() +
  geom_bar(aes(reorder(country, perc), perc), stat = "identity") +
  coord_flip()

# Which country had the highest life expectancy in 1952?

answer <- gapminder %>%
  filter(year == 1952) %>%
  arrange(desc(lifeExp)) %>%
  slice(1) %>%
  pull("country")

# Plot the lifeExp over time for that country

gapminder %>%
  filter(country == answer) %>%
  ggplot() +
  geom_bar(aes(year, lifeExp), stat = "identity")

# Show the average life expectancy per continent in a graph.

gapminder %>%
  group_by(continent) %>%
  summarise(avg_life_exp = mean(lifeExp)) %>%
  ggplot() +
  geom_bar(aes(continent, avg_life_exp), stat = "identity")

# Calculate the average life expectancy per year and per continent and
# show in a plot

gapminder %>%
  group_by(year, continent) %>%
  summarise(avg_lifeExp = mean(lifeExp)) %>%
  ggplot() +
  geom_bar(aes(year, avg_lifeExp, fill = continent), 
           stat = "identity", position = "dodge")

# Create 3 life expectancy groups; low: lifeExp < 50, medium: lifeExp < 65
# and high: the rest. Show in a graph the size of these groups per year.

gapminder %>%
  mutate(lifeExp_group = case_when(
    lifeExp < 50 ~ "low",
    lifeExp < 65 ~ "medium",
    TRUE ~ "high"
  )) %>%
  ggplot() +
  geom_bar(aes(year, fill = lifeExp_group), position = "dodge")

# Count the number of countries in a continent and show in a graph

gapminder %>%
  count(continent, country) %>%
  count(continent) %>%
  ggplot() +
  geom_bar(aes(continent, n), stat = "identity")
