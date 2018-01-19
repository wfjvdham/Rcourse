library(tidyverse)
library(dbplyr)

# Create connection to the database
air <- src_postgres(
  dbname = 'airontime', 
  host = 'sol-eng.cjku7otn8uia.us-west-2.redshift.amazonaws.com', 
  port = '5439', 
  user = 'redshift_user', 
  password = 'ABCd4321')

# List table names
src_tbls(air)

# Create a table reference with tbl
flights <- tbl(air, "flights")
carriers <- tbl(air, "carriers")

# Manipulate the reference as if it were the actual table
clean <- flights %>%
  filter(!is.na(arrdelay), !is.na(depdelay)) %>%
  filter(depdelay > 15, depdelay < 240) %>%
  filter(year >= 2002 & year <= 2007) %>%
  select(year, arrdelay, depdelay, distance, uniquecarrier)


# To see the SQL that dplyr will run.
show_query(clean)

# Extract random 1% sample of training data
random <- clean %>%
  mutate(x = random()) %>%
  collapse() %>%
  filter(x <= 0.01) %>%
  select(-x) %>%
  collect()

# Fit a model to training data
random$gain <- random$depdelay - random$arrdelay

# build model
mod <- lm(gain ~ depdelay + distance + uniquecarrier, data = random)

# Make coefficients lookup table
coefs <- dummy.coef(mod)
coefs_table <- data.frame(
  uniquecarrier = names(coefs$uniquecarrier),
  carrier_score = coefs$uniquecarrier,
  int_score = coefs$`(Intercept)`,
  dist_score = coefs$distance,
  delay_score = coefs$depdelay,
  row.names = NULL, 
  stringsAsFactors = FALSE
)

# Score test data
score <- flights %>%
  filter(year == 2008) %>%
  filter(!is.na(arrdelay) & !is.na(depdelay) & !is.na(distance)) %>%
  filter(depdelay > 15 & depdelay < 240) %>%
  filter(arrdelay > -60 & arrdelay < 360) %>%
  select(arrdelay, depdelay, distance, uniquecarrier) %>%
  left_join(carriers, by = c('uniquecarrier' = 'code')) %>%
  left_join(coefs_table, copy = TRUE) %>%
  mutate(gain = depdelay - arrdelay) %>%
  mutate(pred = int_score + carrier_score + dist_score * distance + delay_score * depdelay) %>%
  group_by(description) %>%
  summarize(gain = mean(1.0 * gain), pred = mean(pred))
show_query(score)
scores <- collect(score)

# Visualize results
ggplot(scores, aes(gain, pred)) + 
  geom_point(alpha = 0.75, color = 'red', shape = 3) +
  geom_abline(intercept = 0, slope = 1, alpha = 0.15, color = 'blue') +
  geom_text(aes(label = substr(description, 1, 20)), size = 4, alpha = 0.75, vjust = -1) +
  labs(title='Average Gains Forecast', x = 'Actual', y = 'Predicted')

# Connect to local example mongo db
# https://docs.mongodb.com/getting-started/shell/import-data/
# sudo service mongod start
# mongoimport --db test --collection restaurants --drop --file ./primer-dataset.json
library(mongolite)
con <- mongo("restaurants", url = "mongodb://localhost/test")
restaurant <- con$find('{"restaurant_id": "30075445"}')

pipeline <- '[
  {
    "$project" : 
    {
      "latitude"  : {
        "$arrayElemAt" : [ "$address.coord", 1 ]
      },
      "longitude" : {
        "$arrayElemAt" : [ "$address.coord", 0 ]
      },
      "date" : {
        "$arrayElemAt" : [ "$grades.date", 0 ]
      },
      "grade" : {
        "$arrayElemAt" : [ "$grades.date", 1 ]
      },
      "score" : {
        "$arrayElemAt" : [ "$grades.date", 2 ]
      }
    }
  }
]'

unwind_restaurants <- con$aggregate(pipeline)
