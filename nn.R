library(neuralnet)
library(tidyverse)

iris <- as_data_frame(iris)

iris_train <- iris %>%
  sample_frac(0.2)

iris_test <- iris %>%
  anti_join(iris_train)

network <- neuralnet(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, 
                     iris_train, hidden = 5)
summary(network)
plot(network, rep = "best")

results <- neuralnet::compute(network, iris_test %>% select(-Sepal.Length, -Species))

compare <- data_frame(
  actual = iris_test$Sepal.Length, 
  prediction = c(results$net.result))
