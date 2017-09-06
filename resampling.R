library(cvTools)
library(boot)
library(tidyverse)

data(iris)
iris <- as_data_frame(iris)

model_all = lm(Sepal.Length ~ ., iris)
summary(model_sepal)
model_pl = lm(Sepal.Length ~ Petal.Length, iris)
summary(model_pl)

cv_all = cvFit(model_all, data=iris, y=iris$Sepal.Length, R=10)
cv_all
cv_pl = cvFit(model_pl, data=iris, y=iris$Sepal.Length, R=10)
cv_pl

mtcars = as_data_frame(mtcars)

cv.error = rep(0, 5)
for (i in 1:5) {
  glm.fit = glm(mpg ~ poly(hp, i), family = gaussian, data = mtcars)
  cv.error[i] = cv.glm(mtcars, glm.fit)$delta[1]
}
cv.error

#boosting
boot.fn = function (data, index) {
  return(coef(lm(mpg ~ hp, data = data, subset = index)))
}
boot(mtcars, boot.fn, R=1000)
coef(lm(mpg ~ hp,mtcars))
