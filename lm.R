## lineair regression example
library(modelr)
library(nycflights13)
library(tidyverse)

ggplot(sim1, aes(x, y)) + 
  geom_point()

ggplot(sim1, aes(x, y)) + 
  geom_point() +
  xlim(0, 11) +
  ylim(0, 30)

sim1_mod <- lm(y ~ x, data = sim1)
summary(sim1_mod)
sim1_coef <- coef(sim1_mod)

ggplot(sim1, aes(x, y)) + 
  geom_point() + 
  geom_abline(intercept = sim1_coef[1], slope = sim1_coef[2], color = "red")

sim1 <- sim1 %>% 
  add_residuals(sim1_mod)

ggplot(sim1, aes(resid)) + 
  geom_histogram(binwidth = 0.5)

ggplot(sim1, aes(x, resid)) + 
  geom_point() 

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

flights = as_data_frame(flights)

## predicir retrasado explore variables
ggplot(flights) +
  geom_point(aes(dep_delay, arr_delay))

ggplot(flights) +
  geom_boxplot(aes(cut(dep_delay, breaks = 10), arr_delay)) +
  theme(axis.text.x = element_text(angle = 90))

ggplot(flights) +
  geom_point(aes(air_time, arr_delay))

ggplot(flights) +
  geom_boxplot(aes(cut(air_time, breaks = 20), arr_delay)) +
  theme(axis.text.x = element_text(angle = 90))

ggplot(flights) +
  geom_boxplot(aes(factor(dest), arr_delay)) +
  theme(axis.text.x = element_text(angle = 90))

ggplot(flights) +
  geom_histogram(aes(air_time))

ggplot(flights) +
  geom_boxplot(aes(factor(month), arr_delay))

#format dataset
flights_factors <- flights %>%
  select(month, day, hour, minute, dep_delay, 
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit()

#lm for arr_delay
model_lm_all = lm(arr_delay ~ ., flights_factors)
summary(model_lm_all)
anova(model_lm_all)

#errors of model_lm_all
flights_factors_with_err <- flights_factors %>%
  add_residuals(model_lm_all) %>%
  rename(resid_lm_all = resid)

ggplot(flights_factors_with_err, aes(resid_lm_all)) + 
  geom_histogram(binwidth = 1)

ggplot(flights_factors_with_err, aes(arr_delay, resid_lm_all)) + 
  geom_point() 

model_lm_dep_delay = lm(arr_delay ~ dep_delay, flights)
summary(model_lm_dep_delay)

anova(model_lm_dep_delay, model_lm_all)

#errors of model_lm_dep_delay
flights_factors_with_err <- flights_factors_with_err %>%
  add_residuals(model_lm_dep_delay) %>%
  rename(resid_lm_dep_delay = resid)

ggplot(flights_factors_with_err, aes(resid_lm_dep_delay)) + 
  geom_histogram(binwidth = 1)

ggplot(flights_factors_with_err, aes(arr_delay, resid_lm_dep_delay)) + 
  geom_point() 

library(broom)

glance(model_lm_dep_delay)
glance(model_lm_all)
