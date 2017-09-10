library(tidyverse)
library(titanic)

train <- as_data_frame(titanic_train)

#logistic regression
#genero
ggplot(train) +
  geom_bar(aes(factor(Survived))) +
  facet_wrap(~Sex)

model_lr_sex <- glm(factor(Survived) ~ factor(Sex), train, family = "binomial") 
summary(model_lr_sex)

#positivve mas probabilidad
#z-value large no es H0
exp(1) / (1 + exp(1))
exp(1-2.5) / (1 + exp(1-2.5))

train_prob <- predict(model_lr_sex, type = "response")
train_prob_df <- tibble(train_prob)
ggplot(train_prob_df) + 
  geom_histogram(aes(train_prob))

treshold = 0.5
train_pred <- ifelse(train_prob > treshold, 1, 0)

#acuracy
sum(train_pred == train$Survived) / nrow(train)

#Precision
sum(train_pred == 1 & train$Survived == 1) / sum(train_pred == 1)

#recall
sum(train$Survived == 1 & train_pred == 1) / sum(train$Survived == 1)
