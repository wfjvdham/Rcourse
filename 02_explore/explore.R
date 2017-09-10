# install packages
# Solo necesitas hacerlo una vez
# Cuando tu tienes los paquetes no nesecitas descargar otra vez
#install.packages("tidyverse")
#install.packages("titanic")

# load packages
# Cada vez cuando tu empiezas con una sesion de R tu necesitas cargar los paquestes
library(tidyverse)
library(titanic)
?titanic_train

# load data
train = as_data_frame(titanic_train)

# examples ggplot
ggplot(train) + 
  geom_point(aes(x = Fare, y = Age))

ggplot(train) + 
  geom_point(aes(Fare, Age, color = Pclass))

ggplot(train) + 
  geom_point(aes(Fare, Age, color = factor(Pclass)))

ggplot(train) + 
  geom_point(aes(Fare, Age, size = factor(Pclass)))

ggplot(train) + 
  geom_point(aes(Fare, Age, alpha = factor(Pclass)))

ggplot(train) + 
  geom_point(aes(Fare, Age, shape = factor(Pclass)))

ggplot(train) + 
  geom_point(aes(Fare, Age)) +
  facet_wrap(factor(Survived) ~ Pclass)

ggplot(train) + 
  geom_point(aes(Fare, Age)) +
  facet_wrap(Sex ~ Pclass)

ggplot(train) + 
  geom_bar(aes(Sex)) +
  facet_wrap(~factor(Survived))

ggplot(train) + 
  geom_bar(aes(Sex)) +
  coord_flip()

ggplot(train) + 
  geom_boxplot(aes(factor(Survived), Fare)) +
  ylim(0,100)

ggplot(train) + 
  geom_histogram(aes(Fare))

ggplot(train) + 
  geom_bar(aes(cut(Fare,c(-1,50,100,1000)))) +
  facet_wrap(~factor(Survived))

# pipe examples
sin(sqrt(log(10)))

10 %>%
  log %>%
  sqrt %>%
  sin

#dplyr examples
train_male <- train %>% 
  filter(Sex == "male")

ggplot(train_male) + 
  geom_bar(aes(Sex))

train_male_class1 <- train %>% 
  filter(Sex != "male" & Pclass == 1)

ggplot(train_male_class1) + 
  geom_bar(aes(factor(Pclass)))

train_male_class12 <- train %>% 
  filter(Sex == "male" & Pclass %in% c(1, 2))

ggplot(train_male_class12) + 
  geom_bar(aes(factor(Pclass)))

train <- train %>% 
  arrange(Age)

train %>% 
  arrange(desc(Age))

train %>%
  select(Sex, Fare)

train_no_sex <- train %>%
  select(-Sex)
train_no_sex

train %>%
  select(Sex:Ticket)

train %>%
  mutate(Age_10 = Age + 10) %>%
  select(Age_10, Age)

train %>%
  group_by(Sex) %>%
  summarise(n = n())

train %>%
  group_by(Sex) %>%
  summarise(mean_age = mean(Age))

train %>%
  group_by(Sex) %>%
  summarise(mean_age = mean(Age, na.rm = TRUE),
            n = n())

train %>%
  group_by(Pclass) %>%
  summarise(mean_fare = mean(Fare, na.rm = TRUE))

#functiones utiles
train %>%
  slice(1)

train %>%
  slice(1:5)

nrow(flights)

summary(train)

train %>%
  na.omit() %>%
  nrow

cut(train$Age, breaks = 10)

cut(train$Age, breaks = c(0,15,31))

seq(1, 8)

seq(1, 8, 0.1)

train %>%
  sample_frac(0.5) %>%
  nrow

train %>%
  sample_n(100) %>%
  nrow
