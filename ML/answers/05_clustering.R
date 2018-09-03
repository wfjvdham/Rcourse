library(tidyverse)
iris_train <- iris %>% 
  select(-Species)
kc <- kmeans(iris_train, 3)

table(iris$Species, kc$cluster)

iris %>%
  mutate(cluster = as.factor(kc$cluster)) %>%
  ggplot() +
  geom_point(aes(Petal.Length, Petal.Width, color = cluster, shape = Species))

hc = hclust(dist(iris_train))
plot(hc, hang = -1, labels = iris$Species)
