library(leaps)
library(tidyverse)
library(glmnet)

#model for iris
iris <- as_data_frame(iris)

regfit <- regsubsets(Sepal.Length ~ ., iris, method = "forward", nvmax = 19)
regfit_backward <- regsubsets(Sepal.Length ~ ., iris, method = "backward", nvmax = 19)

model <- lm(Sepal.Length ~ ., data = iris)
step_model <- step(model)

summary_regfit <- summary(regfit)
summary_regfit
summary(regfit_backward)

names(summary_regfit)
summary_regfit$adjr2
summary_regfit$rsq
plot (regfit, scale = "adjr2")

coef(regfit, 2)

x <- model.matrix(Sepal.Length ~ ., data = iris)
x <- x[,-1]

#alpha 0 is ridge 1 is lasso
lasso = glmnet(x, iris$Sepal.Length, alpha = 1)
plot(lasso)
print(lasso)

ridge = glmnet(x, iris$Sepal.Length, alpha = 0)
plot(ridge)

set.seed(1)
cv.lasso = cv.glmnet(x, iris$Sepal.Length, alpha = 1)
plot(cv.lasso)

cv.ridge = cv.glmnet(x, iris$Sepal.Length, alpha = 0)
plot(cv.ridge)

coef(cv.lasso, s = "lambda.min")
coef(cv.ridge, s = "lambda.min")
