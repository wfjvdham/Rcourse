library(tidyverse)
library(nycflights13)
library(party)
library(randomForest)
library(modelr)

#format dataset
flights_factors <- flights %>%
  mutate(carrier = factor(carrier),
         origin = factor(origin)) %>%
  select(month, day, hour, minute, dep_delay, 
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit() 

flights_factors_small <- flights_factors %>%
  sample_n(10000)

forrest <- randomForest(arr_delay ~ ., data=flights_factors_small, 
                        do.trace = TRUE, importance=TRUE, ntree=100)
print(forrest)
varImpPlot(forrest)

#errors of forrest
flights_factors_with_err <- flights_factors %>%
  add_residuals(forrest) %>%
  rename(resid_rm = resid)

ggplot(flights_factors_with_err, aes(resid_rm)) + 
  geom_histogram(binwidth = 1)

ggplot(flights_factors_with_err, aes(arr_delay, resid_rm)) + 
  geom_point() 
