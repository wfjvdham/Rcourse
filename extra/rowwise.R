library(tidyverse)

df <- tibble(
  patient = c(rep(1, 5), rep(2, 5)),
  a = runif(10),
  b = runif(10),
  c = runif(10)
)

df %>%
  rowwise() %>%
  mutate(any_more_half = any(c(a, b, c) > 0.5))

df %>%
  pivot_longer(-patient, names_to = "name", values_to = "value") %>%
  group_by(patient) %>%
  summarise(any_more_half = any(value > 0.5))
