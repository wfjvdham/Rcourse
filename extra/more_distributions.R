library(tidyverse)

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
