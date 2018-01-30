library(tidyverse)

# t-distribucion
# Used when the sample size is smaller than 30
# df is n_observations - 1
# higher df is closer to normal, df <= 30 normal

x <- seq(-10, 10, by = .1)

ggplot() +
  geom_point(aes(x, dt(x, 2)), color = "red") +
  geom_point(aes(x, dt(x, 6)), color = "blue")

#find 95% conf interfal for two tails
df = 18
t_star = 2.1
pt(t_star, df) - pt(t_star, df, lower.tail = F)

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
