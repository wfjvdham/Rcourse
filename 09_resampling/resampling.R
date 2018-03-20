library(tidyverse)
library(ISLR)

set.seed(1)
set.seed(2)

#validation set approach
auto_train <- Auto %>%
  sample_frac(0.5)

auto_test <- Auto %>%
  anti_join(auto_train)

model_hp = lm(mpg ~ horsepower, data = auto_train)
summary(model_hp)

auto_train %>%
  mutate(prediction = predict(model_hp, auto_train)) %>%
  select(mpg, prediction, horsepower) %>%
  mutate(SE = (mpg - prediction)^2) %>%
  summarise(MSE = mean(SE))

auto_test %>%
  mutate(prediction = predict(model_hp, auto_test)) %>%
  select(mpg, prediction, horsepower) %>%
  mutate(SE = (mpg - prediction)^2) %>%
  summarise(MSE = mean(SE))

model_hp_2 = lm(mpg ~ poly(horsepower, 2), data = auto_train)
model_hp_3 = lm(mpg ~ poly(horsepower, 3), data = auto_train)
summary(model_hp_2)
summary(model_hp_3)

auto_test %>%
  mutate(prediction = predict(model_hp_2, auto_test)) %>%
  select(mpg, prediction, horsepower) %>%
  mutate(SE = (mpg - prediction)^2) %>%
  summarise(MSE = mean(SE))

auto_test %>%
  mutate(prediction = predict(model_hp_3, auto_test)) %>%
  select(mpg, prediction, horsepower) %>%
  mutate(SE = (mpg - prediction)^2) %>%
  summarise(MSE = mean(SE))

#k-fold validation
library(boot)

1:10 %>%
  map_dbl(function(i) {
    glm_fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
      cv.glm(Auto, glm_fit, K = 10)$delta[1]
  })

#examples using other packages
#caret
# library(caret)
# ctrl <- trainControl(method = "cv", savePred = T, number = 5)
# mod <- train(Sepal.Length ~ ., data = iris, method = "lm", trControl = ctrl)
# mod$pred
# mod$resampled
# mod$results

#cvTools
# library(cvTools)
# 
# model_all = lm(Sepal.Length ~ ., iris)
# summary(model_all)
# model_pl = lm(Sepal.Length ~ Petal.Length, iris)
# summary(model_pl)
# 
# cv_all = cvFit(model_all, data=iris, y=iris$Sepal.Length, K=5)
# cv_all
# cv_pl = cvFit(model_pl, data=iris, y=iris$Sepal.Length, K=5)
# cv_pl

#boosting
library(infer)

mtcars <- as_data_frame(mtcars) %>%
  mutate(cyl = factor(cyl),
         vs = factor(vs),
         am = factor(am),
         gear = factor(gear),
         carb = factor(carb))

# calculate the difference in the means of mpg grouped by am
diff_means <- mtcars %>%
  specify(mpg ~ am) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "diff in means", order = c("1", "0"))

ggplot(diff_means) +
  geom_histogram(aes(stat), binwidth = 0.5) +
  labs(title = "Bootstrap difference of means")

quantiles <- diff_means %>%
  summarize(lower_bound = quantile(stat, 0.05),
            upper_bound = quantile(stat, 0.95))

ggplot(diff_means) +
  geom_histogram(aes(stat), binwidth = 0.5) +
  labs(title = "Bootstrap difference of means")  +
  geom_vline(xintercept = quantiles$lower_bound) +
  geom_vline(xintercept = quantiles$upper_bound)
