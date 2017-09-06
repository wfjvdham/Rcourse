#seed
set.seed(5)
#random numbers
runif(10)
runif(10, 5.0, 7.5)
sample(1:10, 2)
sample(1:10, 20)
sample(1:10, 20, replace =TRUE)

#mean
dice <- sample(1:6, 1000000, replace = TRUE)
mean(dice)

mean(train$Age)
mean(train$Age, na.rm = TRUE)

#median
list1 <- c(3,5,8,9,600)
list2 <- c(60,3,5,9,8)
list3 <- c(3,4,5,90)

median(list1)
mean(list1)
median(list2)
median(list3)

#mode
list4 <- c(1, 1, 1, 2, 3, 4, 4)

table(list4)
sort(table(list4), decreasing = TRUE)

#variance
dice_10 <- sample(1:10, 1000000, replace = TRUE)

mean(dice_10)

sd(dice_10)
sd(dice)

var(dice)
var(dice_10)
var(train$Age, na.rm = TRUE)

#normal distribution
dnorm(0, mean = 1, sd = 1)
pnorm(-1, mean = 0, sd = 1)

x <- seq(-10, 10, by = .1)

ggplot() +
  geom_point(aes(x, dnorm(x, mean = 0, sd = 1)), color = "red") +
  geom_point(aes(x, dnorm(x, mean = 0, sd = 4)), color = "blue")

ggplot() +
  geom_point(aes(x, pnorm(x, mean = 0, sd = 1)), color = "red") +
  geom_point(aes(x, pnorm(x, mean = 0, sd = 4)), color = "blue")

results = tibble(result = rowSums(replicate(100, sample(0:100, 100000, replace=T))), group = 1)

ggplot(results) +
  geom_histogram(aes(result), binwidth = 10)

ggplot(results) +
  geom_boxplot(aes(group, result))

#google intravista
library(tidyverse)
n=200
x <- seq(1, n)
maquina20 <- ifelse(runif(n) < 0.2, 1, 0)
maquina30 <- ifelse(runif(n) < 0.3, 1, 0)
mean(maquina20)
mean(maquina30)
sd(maquina20)
sd(maquina30)

ggplot() +
  geom_point(aes(x, cumsum(maquina20)/x), color = "red") +
  geom_point(aes(x, cumsum(maquina30)/x), color = "blue") +
  ggtitle("Averages, blue = 30% red = 20%")

sds20 <- rep(0, n)
sds30 <- rep(0, n)
for (i in 1:n) {
  sds20[i] = sd(maquina20[1:i])
  sds30[i] = sd(maquina30[1:i])
}

ggplot() +
  geom_point(aes(x, sds20), color = "red") +
  geom_point(aes(x, sds30), color = "blue") +
  ggtitle("Standard deviations, blue = 30% red = 20%")

#cumulative probability that this sample is from maquina20
p20 <- rep(0, n)
p30 <- rep(0, n)
for(i in 1:n) {
  p20[i] <- ifelse(maquina20[i]==0, 0.8, 0.2)
  p30[i] <- ifelse(maquina20[i]==0, 0.7, 0.3)
}
cump20 <- cumprod(p20)
cump30 <- cumprod(p30)
normcump20 <- rep(0, n)
normcump30 <- rep(0, n)
for(i in 1:n) {
  normcump20[i] <- cump20[i] / (cump20[i] + cump30[i])
  normcump30[i] <- cump30[i] / (cump20[i] + cump30[i])
}
ggplot() +
  geom_point(aes(x, normcump20), color = "red") +
  geom_point(aes(x, normcump30), color = "blue") +
  ggtitle("Probabilities for 20 group, assumptions: blue = 30% red = 20%")

p20 <- rep(0, n)
p30 <- rep(0, n)
for(i in 1:n) {
  p20[i] <- ifelse(maquina30[i]==0, 0.8, 0.2)
  p30[i] <- ifelse(maquina30[i]==0, 0.7, 0.3)
}
cump20 <- cumprod(p20)
cump30 <- cumprod(p30)
normcump20 <- rep(0, n)
normcump30 <- rep(0, n)
for(i in 1:n) {
  normcump20[i] <- cump20[i] / (cump20[i] + cump30[i])
  normcump30[i] <- cump30[i] / (cump20[i] + cump30[i])
}
ggplot() +
  geom_point(aes(x, normcump20), color = "red") +
  geom_point(aes(x, normcump30), color = "blue") +
  ggtitle("Probabilities for 30 group, assumptions: blue = 30% red = 20%")

#poisson distribution
#WC 2,5 goals per game

#excactly x goals
dpois(2, lambda=2.5)

#less than x goals
ppois(0, lambda=2.5)

library(glm2)
data(crabs)
crabs = as_data_frame(crabs)

ggplot(crabs) +
  geom_point(aes(Width, Satellites))

model=glm(Satellites ~ Width, crabs, family=poisson(link=log))
summary(model)

crabs <- cbind(crabs, model$fitted)

ggplot(crabs) +
  geom_point(aes(Width, Satellites), color="blue") +
  geom_point(aes(Width, model$fitted), color="red")

#-3.30476 + 0.16405Wi
exp(-3.30 + 0.164 * 25)
exp(-3.30 + 0.164 * 30)
