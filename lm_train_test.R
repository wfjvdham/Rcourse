library(tidyverse)
library(nycflights13)
library(randomForest)
library(broom)

flights <- as_tibble(flights)

flights <- flights %>%
  mutate(random_n = runif(336776)) %>%
  mutate(in_training = random_n > 0.25) %>%
  mutate(carrier = factor(carrier),
         origin = factor(origin)) %>%
  select(month, day, hour, minute, dep_delay, in_training,
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit() 

flights_training <- flights %>%
  filter(in_training)

flights_test <- flights %>%
  filter(!in_training)

flights_fit_lm <- lm(arr_delay ~ dep_delay, data = flights_training)
flights_fit <- randomForest(
  arr_delay ~ dep_delay, data = flights_training, do.trace = TRUE, 
  importance = TRUE, ntree = 10
)
summary(flights_fit_lm)

tidy(flights_fit_lm)
glance(flights_fit_lm)

result <- flights_test %>%
  mutate(pred = predict(flights_fit, newdata = flights_test)) %>%
  select(pred, arr_delay) %>%
  mutate(resid = pred - arr_delay) %>%
  mutate(resid_2 = resid^2) %>%
  summarise(rmse = sum(resid_2, na.rm = TRUE))

result_lm <- flights_test %>%
  mutate(pred = predict(flights_fit_lm, newdata = flights_test)) %>%
  select(pred, arr_delay) %>%
  mutate(resid = pred - arr_delay) %>%
  mutate(resid_2 = resid^2) %>%
  summarise(rmse = sum(resid_2, na.rm = TRUE))
