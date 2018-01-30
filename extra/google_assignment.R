library(tidyverse)

#google intravista

# a priori:
# M: 30% ~ 0.5
# M: 20% ~ 0.5
# result is 0
# P(m30 | results) = P(results | m30) * P(m30) / P(results) = .7 * .5 / 0.75 = 0.46
# P(m20 | results) = P(results | m20) * P(m20) / P(results) = .8 * .5 / 0.75 = 0.53

# M E = z SE = 1.96 × sqrt( p(1 − p) / n )  ≤ 0.04
# pag. 127

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
