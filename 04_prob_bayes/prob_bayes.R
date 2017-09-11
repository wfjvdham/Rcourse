library(tidyverse)
library(titanic)
library(e1071)

train = as_data_frame(titanic_train)
test = as_data_frame(titanic_test)

# titanic - model - Naive Bayes classifier
# los proximos modelos no functionan con columnas de typo character (= string)
# nosotros nesecitamos cambiar esos a factores o remover esas columnas
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
