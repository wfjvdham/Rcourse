library(sparklyr)
library(tidyverse)

#Installar spark
spark_install(version = "2.1.0")

#conficurar tu connection de Spark
conf <- spark_config()
conf$`sparklyr.shell.driver-memory` <- "7G"  
conf$spark.memory.fraction <- 0.8 #default es 40%

#connectar
sc <- spark_connect(master = "local", config = conf, version = "2.1.0")
#http://127.0.0.1:4040/executors/

#cargar data en Spark
library(nycflights13)
flights <- as_data_frame(flights)
write_csv(flights, "/home/wim/Descargas/rcourse/flights.csv", na = "NA")

sp_flights <- spark_read_csv(sc, 
                             name = "flights", 
                             path = "/home/wim/Descargas/rcourse/flights.csv", 
                             memory = FALSE)
#http://127.0.0.1:4040/storage/ no tiene nada proque eso sole es 
#decir la direcion de los datos
#memory = TRUE si es en storage
object.size(sp_flights)

#o directamente con copy_to

flights_table <- sp_flights %>%
  mutate(dep_delay = as.numeric(dep_delay),
         sched_dep_time = as.numeric(sched_dep_time)) %>%
  select(origin, dest, sched_dep_time, sched_arr_time, arr_delay, dep_delay, month, month)
flights_table %>% head

sp_flights  %>% 
  head %>% 
  show_query()

sp_flights %>%
  group_by(dest) %>%
  summarise(n = n(),
            mean_sdt = mean(sched_dep_time),
            mean_sat = mean(sched_arr_time))
#http://127.0.0.1:4040/jobs/

#cargar en memoria despues http://127.0.0.1:4040/storage/ tiene un table
subset_table <- flights_table %>% 
  compute("flights_subset")

subset_table %>%
  group_by(dest) %>%
  summarise(n = n(),
            mean_sdt = mean(sched_dep_time),
            mean_sat = mean(sched_arr_time))

sp_flights %>% 
  sample_frac(0.0001) %>% 
  show_query()

#functiones utiles
subset_table %>%
  group_by(origin, dest) %>%
  tally() %>%
  head()

subset_table %>%
  filter(origin == "EWR" | origin == "JFK") %>%
  sdf_pivot(origin~dest) 

split_table <- subset_table %>%
  sdf_partition(training = 0.2, testing = 0.8)
split_table$training
training <- compute(split_table$training, "training")

subset_table %>%
  ft_binarizer(input.col =  "dep_delay", 
               output.col = "delayed",
               threshold = 15) %>%
  head(200)

subset_table %>%
  ft_bucketizer(input.col =  "sched_dep_time",
                output.col = "DepHour",
                splits = c(0, 400, 800, 1200, 1600, 2000, 2400)) %>%
  head(100)

sample_data <- subset_table %>%
  filter(!is.na(dep_delay)) %>%
  ft_binarizer(input.col = "dep_delay",
               output.col = "delayed",
               threshold = 30) %>% 
  ft_bucketizer(input.col =  "sched_dep_time",
                output.col = "DepHour",
                splits = c(0, 400, 800, 1200, 1600, 2000, 2400)) %>%
  mutate(DepHour = paste0("h", as.integer(DepHour))) %>%
  sdf_partition(training = 0.2, testing = 0.8)

training <- compute(sample_data$training, "training")

#tu modelo corres en Spark sin cargar datos en R
delayed_model <- ml_logistic_regression(training, delayed ~ dep_delay + DepHour) 
summary(delayed_model)

delayed_testing <- sdf_predict(delayed_model, sample_data$testing) 
delayed_testing %>% head

delayed_testing %>%
  group_by(delayed, prediction) %>%
  tally 

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

#spark_apply
training %>%
  spark_apply(nrow)

training %>%
  spark_apply(nrow, group_by =  "month", columns = "count")

spark_apply(
  training,
  function(e) broom::tidy(glm(delayed ~ arr_delay, data = e, family = "binomial")),
  names = c("term", "estimate", "std.error", "statistic", "p.value"),
  group_by = "origin")
