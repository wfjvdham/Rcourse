library(tidyverse)
library(titanic)
train = as_data_frame(titanic_train)
test = as_data_frame(titanic_test)

#example precision & recall
# verdad: 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
# model1: 1, 1, 1, 1, 1, 1, 1, 1, 1, 1  P:0.5 R:1
# model2: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  P:0   R:0
# model3: 1, 1, 1, 1, 1, 0, 0, 0, 0, 0  P:1   R:1

# titanic - model - all death
ggplot(train) +
  geom_bar(aes(factor(Survived)))

train <- train %>%
  mutate(predSurvived = 0)

table(train$predSurvived, train$Survived)

sum(train$predSurvived == train$Survived) / nrow(train)

#titanic - model - male death, female alive
ggplot(train) +
  geom_bar(aes(factor(Survived))) +
  facet_wrap(~Sex)

train <- train %>%
  mutate(predSurvived = ifelse(Sex == "male", 0, 1))

table(train$predSurvived, train$Survived)
sum(train$predSurvived == train$Survived) / nrow(train)

#titanic - model - female and childeren survive rest death
train <- train %>%
  mutate(Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age),
         predSurvived = ifelse(Sex == "female", 1, 0),
         predSurvived = ifelse(Age < 7, 1, predSurvived))

table(train$predSurvived, train$Survived)
sum(train$predSurvived == train$Survived) / nrow(train)
