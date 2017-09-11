library(tidyverse)
library(rsparkling)
library(sparklyr)
library(h2o)

options(rsparkling.sparklingwater.version = "2.1.0")
sc <- spark_connect(master = "local")
mtcars_tbl <- copy_to(sc, mtcars, "mtcars", overwrite = TRUE)
h2o_flow(sc, strict_version_check = FALSE)
mtcars_h2o <- as_h2o_frame(sc, mtcars_tbl, strict_version_check = FALSE)
mtcars_glm <- h2o.glm(x = c("wt", "cyl"), 
                      y = "mpg",
                      training_frame = mtcars_h2o,
                      lambda_search = TRUE)
mtcars_glm

spark_disconnect(sc)
