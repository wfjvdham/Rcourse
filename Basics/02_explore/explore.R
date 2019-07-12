# install packages
# install.packages("tidyverse")
# install.packages("titanic")

# load packages
library(tidyverse)
library(titanic)
?titanic_train

# load data
train <- as_tibble(titanic_train)

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
  facet_wrap(Survived ~ Pclass)

ggplot(train) + 
  geom_point(aes(Fare, Age)) +
  facet_wrap(Sex ~ Pclass)

ggplot(train) + 
  geom_bar(aes(Sex)) +
  facet_wrap(Pclass ~ Survived, ncol = 2)

ggplot(train) + 
  geom_bar(aes(Sex)) +
  facet_wrap(~ Survived) +
  labs(title = "...", x = "...", y = "...")

ggplot(train) + 
  geom_bar(aes(Sex)) +
  coord_flip()

ggplot(train) + 
  geom_boxplot(aes(factor(Pclass), Fare))

ggplot(train) + 
  geom_boxplot(aes(factor(Pclass), Fare)) +
  ylim(0, 100)

ggplot(train) + 
  geom_boxplot(aes(factor(Pclass), Fare)) + 
  coord_cartesian(ylim = c(0, 100))

ggplot(train) + 
  geom_histogram(aes(Fare))

ggplot(train) + 
  geom_histogram(aes(Fare), binwidth = 100)

ggplot(train) + 
  geom_bar(aes(cut(Fare, c(-Inf, 50, 100, Inf)))) +
  facet_wrap(Sex ~ Survived)

# add lines

ggplot(train) + 
  geom_point(aes(x = Fare, y = Age)) +
  geom_vline(aes(xintercept = mean(Fare))) +
  geom_hline(aes(yintercept = mean(Age, na.rm = TRUE)))

# dplyr examples
train_male <- train %>% 
  filter(Sex == "male") 

ggplot(train_male) + 
  geom_bar(aes(Sex))

train_male_class1 <- train %>% 
  filter(Sex == "male" & Pclass == 1)

train_male_class1 <- filter(train, Sex == "male" & Pclass == 1)

ggplot(train_male_class1) + 
  geom_bar(aes(factor(Pclass)))

train_male_class12 <- train %>% 
  filter(Sex == "male") %>%
  filter(Pclass %in% c(1, 2))

ggplot(train_male_class12) + 
  geom_bar(aes(factor(Pclass)))

train <- train %>% 
  arrange(Age)

train <- train %>% 
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

train <- train %>%
  mutate(Pclass_factor = factor(Pclass))

train %>%
  group_by(Sex) %>%
  summarise(
    n = n(),
    missing = sum(is.na(Age))
  ) %>%
  mutate(perc_missing = missing / sum(n) * 100)

train %>%
  count(Sex)

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

train %>%
  mutate(groups = cut(Fare, c(-1, 50, 100, 1000))) %>%
  group_by(groups) %>%
  summarise(n = n())

#geom_bar identity

ggplot(train) +
  geom_bar(aes(Sex))

mean_age_sex <- train %>%
  group_by(Sex) %>%
  summarise(mean_age = mean(Age, na.rm = TRUE))

ggplot(mean_age_sex) +
  geom_bar(aes(mean_age))

ggplot(mean_age_sex) +
  geom_bar(aes(Sex, mean_age), stat = "identity")

# usefull functions
train %>%
  arrange(desc(Age)) %>%
  slice(1:50)

train %>%
  slice(1:5)

nrow(train)

summary(train)

train %>%
  na.omit() %>%
  nrow()

cut(train$Age, seq(0, 100, 5))

cut(train$Age, c(0, 15, 31))

cut(train$Age, 10)

seq(1, 8)

seq(1, 8, 0.1)

set.seed(5342)

train %>%
  sample_frac(0.5) %>%
  nrow()

train %>%
  sample_n(100) %>%
  nrow()
