library(tidyverse)
library(e1071)
library(titanic)

train <- as_data_frame(titanic_train)

# titanic - Naive Bayes classifier
train_factor <- train %>%
  mutate(Survived = factor(Survived),
         Sex = factor(Sex),
         Embarked = factor(Embarked)) %>%
  select(-Name, -Ticket, -Cabin)

classifier <- naiveBayes(Survived ~ Sex + Age, train_factor)

print(classifier)

train_factor <- train_factor %>%
  mutate(predSurvived = predict(classifier, train_factor, type = "class"))

table(train_factor$predSurvived, train_factor$Survived)
sum(train_factor$predSurvived == train_factor$Survived) / nrow(train_factor)
