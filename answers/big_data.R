library(tidyverse)
library(dbplyr)

# Create connection to the database
air <- src_postgres(
  dbname = 'airontime', 
  host = 'sol-eng.cjku7otn8uia.us-west-2.redshift.amazonaws.com', 
  port = '5439', 
  user = 'redshift_user', 
  password = 'ABCd4321')

# Create a table reference with tbl
flights <- tbl(air, "flights")
carriers <- tbl(air, "carriers")

# Manipulate the reference as if it were the actual table
clean <- flights %>%
  filter(!is.na(arrdelay), !is.na(depdelay)) %>%
  filter(depdelay > 15, depdelay < 240) %>%
  filter(year >= 2002 & year <= 2007) %>%
  select(year, arrdelay, depdelay, uniquecarrier)

# Extract random 1% sample of training data
random <- clean %>%
  mutate(x = random()) %>%
  collapse() %>%
  filter(x <= 0.01) %>%
  select(-x) %>%
  collect()

# build model
mod <- lm(arrdelay ~ depdelay + uniquecarrier, data = random)

# Make coefficients lookup table
coefs <- dummy.coef(mod)
coefs_table <- data.frame(
  uniquecarrier = names(coefs$uniquecarrier),
  carrier_score = coefs$uniquecarrier,
  int_score = coefs$`(Intercept)`,
  delay_score = coefs$depdelay,
  row.names = NULL, 
  stringsAsFactors = FALSE
)

# Score test data
score <- flights %>%
  filter(year == 2008) %>%
  filter(!is.na(arrdelay) & !is.na(depdelay)) %>%
  filter(depdelay > 15 & depdelay < 240) %>%
  filter(arrdelay > -60 & arrdelay < 360) %>%
  select(arrdelay, depdelay, uniquecarrier) %>%
  left_join(carriers, by = c('uniquecarrier' = 'code')) %>%
  left_join(coefs_table, copy = TRUE) %>%
  mutate(pred = int_score + carrier_score + delay_score * depdelay) %>%
  group_by(uniquecarrier) %>%
  summarize(arrdelay = mean(1.0 * arrdelay), pred = mean(pred))
scores <- collect(score)

# Visualize results
ggplot(scores, aes(arrdelay, pred)) + 
  geom_point(alpha = 0.75, color = 'red', shape = 3) +
  geom_abline(intercept = 0, slope = 1, alpha = 0.15, color = 'blue') +
  geom_text(aes(label = substr(uniquecarrier, 1, 20)), size = 4, alpha = 0.75, vjust = -1)
