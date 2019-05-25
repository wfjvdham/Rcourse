library(tidyverse)

df <- tibble(
  "group" = rep(1:5, 4),
  "a" = sample(0:1, 20, replace = TRUE),
  "b" = sample(0:1, 20, replace = TRUE),
  "c" = sample(0:1, 20, replace = TRUE)
)

perc <- function(col) {
  sum(col) / length(col)
}

df %>%
  group_by(group) %>%
  summarise_all(perc)
