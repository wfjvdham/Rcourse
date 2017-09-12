library(sparklyr)
library(dplyr)
library(tidyverse)

conf <- spark_config()
conf$`sparklyr.shell.driver-memory` <- "7G"  
conf$spark.memory.fraction <- 0.8 

sc <- spark_connect(master = "local", config = conf, version = "2.1.0")

#other ml to practice
# copy mtcars into spark
mtcars_tbl <- copy_to(sc, mtcars)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))

prediction <- sdf_predict(fit, partitions$testing) 
prediction %>% 
  select(mpg, prediction)
