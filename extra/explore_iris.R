#play with iris data
data(iris)
iris <- as_data_frame(iris)
?iris

ggplot(iris) +
  geom_point(aes(Sepal.Length, Sepal.Width, color = Species))

ggplot(iris) +
  geom_point(aes(Petal.Length, Petal.Width, color = Species))

model_sepal = lm(Sepal.Length ~ ., iris)
summary(model_sepal)

model_petal = lm(Petal.Length ~ ., iris)
summary(model_petal)

model_species_forrest = randomForest(Species ~ ., iris, 
                                     do.trace = TRUE, importance=TRUE, ntree=2000)
varImpPlot(model_species_forrest)

iris_predictions <- iris %>%
  add_predictions(model_species_forrest)

iris_train <- iris %>%
  sample_frac(0.6)

iris_test <-iris  %>%
  anti_join(iris_train)

model_species_forrest_train = randomForest(Species ~ ., iris_train, 
                                           do.trace = TRUE, importance=TRUE, ntree=2000)
iris_test <- iris_test %>%
  add_predictions(model_species_forrest_train)

sum(iris_test$Species == iris_test$pred) / nrow(iris_test)

library(party)

tree <- ctree(Species ~ ., 
              #              controls = ctree_control(mincriterion = 0.00001),
              iris)
plot(tree)

#more datasets
library(help = "datasets")
