library(tidyverse)

USArrests <- as_data_frame(USArrests)

map(USArrests, mean)

map(USArrests, var)

map(USArrests$Murder, sqrt)

prc_results <- prcomp(USArrests, scale. = TRUE)
prc_results$center
prc_results$scale
