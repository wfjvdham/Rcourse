library(tidyverse)
library(randomForest)
library(nycflights13)
library(caret)

#format dataset
flights_factors_train_test <- flights %>%
  mutate(inTrain = runif(nrow(flights)) > 0.95) %>%
  mutate(carrier = factor(carrier),
         origin = factor(origin)) %>%
  select(month, day, hour, minute, dep_delay, inTrain,
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit() 

flights_factors_train <- flights_factors_train_test %>%
  filter(inTrain == TRUE)

flights_factors_test <- flights_factors_train_test %>%
  filter(inTrain == FALSE)

train_control <- trainControl(method = "cv", number = 5, savePredictions = TRUE)

model <- train(arr_delay ~ ., data = flights_factors_train, 
               trControl = train_control, method = "rpart")
summary(model)
plot(model)
rattle::fancyRpartPlot(model$finalModel)

results_tree <- flights_factors_test %>%
  mutate(pred = predict(model, flights_factors_test)) %>%
  mutate(resid = arr_delay - pred,
         error_2 = resid^2) %>%
  select(arr_delay, pred, resid, error_2)

ggplot(results_tree) + 
  geom_histogram(aes(resid), binwidth = 1)

ggplot(results_tree) + 
  geom_point(aes(arr_delay, resid)) 

mean(results_tree$error_2)

forrest <- randomForest(arr_delay ~ ., data = flights_factors_train, 
                        do.trace = TRUE, importance = TRUE, ntree = 100)
print(forrest)
varImpPlot(forrest)

#errors of forrest
results_rf <- flights_factors_test %>%
  mutate(pred = predict(forrest, flights_factors_test)) %>%
  mutate(resid = arr_delay - pred,
         error_2 = resid^2) %>%
  select(arr_delay, pred, resid, error_2)

ggplot(results_rf) + 
  geom_histogram(aes(resid), binwidth = 1)

ggplot(results_rf) + 
  geom_point(aes(arr_delay, resid)) 

mean(results_rf$error_2)
