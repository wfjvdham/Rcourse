library(tidyverse)

df <- tibble(
  patient = 1:10,
  a = runif(10),
  b = runif(10),
  c = runif(10)
)

df$patient


df %>%
  rowwise() %>%
  mutate(any_more_half = any(c(a, b, c) > 0.5))

df %>%
  pivot_longer(-patient, names_to = "name", values_to = "value") %>%
  group_by(patient) %>%
  summarise(any_more_half = any(value > 0.5))

# https://dplyr.tidyverse.org/dev/articles/rowwise.html
# https://tidyr.tidyverse.org/articles/pivot.html
# https://www.tidyverse.org/blog/2020/04/dplyr-1-0-0-colwise/