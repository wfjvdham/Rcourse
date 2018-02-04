## lineair regression example
library(modelr)
library(tidyverse)

## interactions lm
ggplot(sim3, aes(x1, y)) + 
  geom_point(aes(colour = x2))

ggplot(sim3, aes(x1, y)) + 
  geom_point() +
  facet_grid(~x2)

mod1 <- lm(y ~ x1 + x2, data = sim3)
mod2 <- lm(y ~ x1 * x2, data = sim3)

summary(mod1)
summary(mod2)
anova(mod1, mod2)
anova(mod2)

grid <- sim3 %>% 
  data_grid(x1, x2) %>% 
  gather_predictions(mod1, mod2)

ggplot(sim3, aes(x1, y, colour = x2)) + 
  geom_point() + 
  geom_line(data = grid, aes(y = pred)) + 
  facet_wrap(~ model)

sim3 <- sim3 %>% 
  gather_residuals(mod1, mod2)

ggplot(sim3, aes(x1, resid, colour = x2)) + 
  geom_point() + 
  facet_grid(model ~ x2)

# y = (Intercept) + (x2b | x2c | x2d) + x1 * x1.coef
# y = (Intercept) + (x2b | x2c | x2d) + x1 * x1.coef + (x2b | x2c | x2d) * (x2b.coef | x2c.coef | x2d.coef)
# x1 = 10 x2 = b
# y = 1.30 + 7.07 + 10 * -0.09 + 10 * -0.76

library(broom)

glance(mod1)
glance(mod2)
