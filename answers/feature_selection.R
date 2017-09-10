library(leaps)
library(tidyverse)
library(nycflights13)

#format dataset
flights <- as_data_frame(flights)

flights_factors <- flights %>%
  select(month, day, hour, minute, dep_delay, 
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit() %>%
  mutate(origin = as.factor(origin),
         carrier = as.factor(carrier)) %>%
  sample_n(100)

regfit <- regsubsets(arr_delay ~ ., flights_factors, method = "forward", nvmax = 19)
summary(regfit)
coef(regfit, 2)

#model for flights
x<-model.matrix(arr_delay~.,data=flights_factors)
x=x[,-1]

#alpha 0 is ridge 1 is lasso
lasso = glmnet(x, flights_factors$arr_delay, alpha = 1)
plot(lasso)

ridge = glmnet(x, flights_factors$arr_delay, alpha = 0)
plot(ridge)

set.seed(1)
cv.lasso = cv.glmnet(x, flights_factors$arr_delay, alpha = 1)
plot(cv.lasso)

cv.ridge = cv.glmnet(x, flights_factors$arr_delay, alpha = 0)
plot(cv.ridge)

coef(cv.lasso, s = "lambda.min")
coef(cv.ridge, s = "lambda.min")
