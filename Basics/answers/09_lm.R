library(tidyverse)
library(nycflights13)
library(modelr)
library(broom)
flights = as_data_frame(flights)

# explore

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
  geom_boxplot(aes(factor(month), arr_delay))

# model arr_delay

mod <- lm(arr_delay ~ dep_delay, data = flights)
summary(mod)

coef <- coef(mod)
ggplot(flights) + 
  geom_point(aes(dep_delay, arr_delay)) + 
  geom_abline(intercept = coef[1], slope = coef[2], color = "red")

flights <- flights %>% 
  add_residuals(mod)

ggplot(flights) + 
  geom_histogram(aes(resid))

ggplot(flights, aes(arr_delay, resid)) + 
  geom_point() 

# model dep_delay + origin

mod_origin <- lm(arr_delay ~ dep_delay + origin, flights)
summary(mod_origin)
summary(mod)

anova(mod, mod_origin)

glance(mod_origin)

# model all

#format dataset
flights_factors <- flights %>%
  select(month, day, hour, minute, dep_delay, 
         arr_delay, origin, carrier, air_time, distance) %>%
  na.omit()

#lm for arr_delay
model_lm_all <- lm(arr_delay ~ ., flights_factors)
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
