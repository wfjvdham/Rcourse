library(tidyverse)
library(randomForest)
library(titanic)
library(caret)
library(party)

train = as_data_frame(titanic_train)

# trees do not work with columns of the type string, so they need to be converted to factors
# or removed from the data frame
train_test_factor <- train %>%
  mutate(inTrain = runif(nrow(train)) > 0.75) %>%
  mutate(Survived = factor(Survived),
         Sex = factor(Sex),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age)) %>%
  select(-Name, -Ticket, -Cabin)

train_factor <- train_test_factor %>%
  filter(inTrain == TRUE)

test_factor <- train_test_factor %>%
  filter(inTrain == FALSE)

summary(train_factor)

train_control <- trainControl(method = "cv", number = 5, savePredictions = TRUE)

model <- train(Survived ~ ., data = train_factor, trControl = train_control, method = "rpart")
summary(model)
plot(model)
rattle::fancyRpartPlot(model$finalModel)

results <- test_factor %>%
  mutate(predTreeCV = predict(model, test_factor)) %>%
  select(predTreeCV, Survived)

#acuracy
sum(results$Survived == results$predTreeCV) / nrow(results)

#Precision
sum(results$Survived == 1 & results$predTreeCV == 1) / sum(results$predTreeCV == 1)

#recall
sum(results$Survived == 1 & results$predTreeCV == 1) / sum(results$Survived == 1)

# For smaller values of mincriterion the tree will be bigger
tree <- ctree(Survived ~ ., train_factor)
plot(tree)

tree_overfitting <- ctree(Survived ~ ., 
                          controls = ctree_control(mincriterion = 0.0001),
                          train_factor)
plot(tree_overfitting)

# the next trees give realy high scores so they are overfitted
results <- results %>%
  mutate(predTree = predict(tree, test_factor))

table(results$predTree, results$Survived)
sum(results$predTree == results$Survived) / nrow(results)

results <- results %>%
  mutate(predTreeOverfitting = predict(tree_overfitting, test_factor))

table(results$predTreeOverfitting, results$Survived)
sum(results$predTreeOverfitting == results$Survived) / nrow(results)

forrest_titanic <- randomForest(Survived ~ ., data = train_factor, 
                                do.trace = TRUE, importance = TRUE, ntree = 200)
varImpPlot(forrest_titanic)
print(forrest_titanic)

results <- results %>%
  mutate(predRandomForrest = predict(forrest_titanic, test_factor))

#acuracy
sum(results$Survived == results$predRandomForrest) / nrow(results)

#Precision
sum(results$Survived == 1 & results$predRandomForrest == 1) / sum(results$predRandomForrest == 1)

#recall
sum(results$Survived == 1 & results$predRandomForrest == 1) / sum(results$Survived == 1)
