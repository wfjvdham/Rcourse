library(tidyverse)
library(randomForest)
library(titanic)
library(party)
library(modelr)

train = as_data_frame(titanic_train)
test = as_data_frame(titanic_test)

# los proximos modelos no functionan con columnas de typo character (= string)
# nosotros nesecitamos cambiar esos a factores o remover esas columnas
train_factor <- train %>%
  mutate(Survived = factor(Survived),
         Sex = factor(Sex),
         Embarked = factor(Embarked)) %>%
  select(-Name, -Ticket, -Cabin)

# titanic - model - tree
# en este paquete para hacer trees no hay el parametro c pero hay el parametro mincriterion
# el mas pequeno el mas profundo es el tree 
# y el mas grande es la probabilidad para overfitting
tree <- ctree(Survived ~ ., train_factor)
plot(tree)

tree_overfitting <- ctree(Survived ~ ., 
                          controls = ctree_control(mincriterion = 0.0001),
                          train_factor)
plot(tree_overfitting)



#IMPORTANTE las scores de los trees son muy altos. Esto es claremente overfitting
train_factor <- train_factor %>%
  mutate(predSurvived = predict(tree, train_factor))

table(train_factor$predSurvived, train_factor$Survived)
sum(train_factor$predSurvived == train_factor$Survived) / nrow(train_factor)

train_factor <- train_factor %>%
  mutate(predSurvived = predict(tree_overfitting, train_factor))

table(train_factor$predSurvived, train_factor$Survived)
sum(train_factor$predSurvived == train_factor$Survived) / nrow(train_factor)

#bagging
sample(1:10, 10, replace = TRUE)

titanic_train = as_data_frame(titanic_train) %>%
  mutate(Name = factor(Name),
         Sex = factor(Sex),
         Ticket = factor(Ticket),
         Cabin = factor(Cabin),
         Embarked = factor(Embarked))  %>%
  select(-Ticket, -Cabin, -Name) %>%
  na.omit()

summary(titanic_train)

forrest_titanic <- randomForest(factor(Survived) ~ ., data=titanic_train, 
                                do.trace = TRUE, importance=TRUE, ntree=2000)
varImpPlot(forrest_titanic)
print(forrest_titanic)

OOBpredictions <- predict(forrest_titanic)
sum(titanic_train$Survived == OOBpredictions) / nrow(titanic_train)

#errors forrrest on titanic
titanic_train <- titanic_train %>%
  add_predictions(forrest_titanic)

#acuracy
sum(titanic_train$Survived == titanic_train$pred) / nrow(titanic_train)

#Precision
sum(titanic_train$Survived == 1 & titanic_train$pred == 1) / sum(titanic_train$pred == 1)

#recall
sum(titanic_train$Survived == 1 & titanic_train$pred == 1) / sum(titanic_train$Survived == 1)
