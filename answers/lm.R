library(nycflights13)
library(modelr)
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
