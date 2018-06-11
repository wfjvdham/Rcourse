library(nycflights13)
library(cvTools)
library(tidyverse)
library(boot)
flights = as_data_frame(flights)

#format dataset
flights_factors <- flights %>%
  select(month, day, hour, minute, dep_delay, 
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit()

model_lm_dep_delay1 = lm(arr_delay ~ poly(dep_delay, 1), flights_factors)
model_lm_dep_delay5 = lm(arr_delay ~ poly(dep_delay, 5), flights_factors)
model_lm_dep_delay10 = lm(arr_delay ~ poly(dep_delay, 10), flights_factors)

summary(model_lm_dep_delay1)$sigma

summary(model_lm_dep_delay1)
summary(model_lm_dep_delay5)
summary(model_lm_dep_delay10)

anova(model_lm_dep_delay1, 
      model_lm_dep_delay5,
      model_lm_dep_delay10)

cv1 = cvFit(model_lm_dep_delay1, data=flights_factors, y=flights_factors$arr_delay, K=5)
cv5 = cvFit(model_lm_dep_delay5, data=flights_factors, y=flights_factors$arr_delay, K=5)
cv10 = cvFit(model_lm_dep_delay10, data=flights_factors, y=flights_factors$arr_delay, K=5)
cv1
cv5
cv10
