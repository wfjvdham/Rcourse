library(tidyverse)

data_dictionary <- tibble(
  column_name = c(rep("geslacht", 3), rep("commal1", 4)),
  value = c(1, 2, 3, 1, 2, 3, 4),
  description = c(
    "Man", "Vrouw", "Ongedifferentieerd", "Ja, actueel",
    "Ja, curatief behandeld < 5j geleden", "Ja, curatief behandeld > 5j geleden",
    "Ja, palliatief behandeld"
  )
)
data <- tibble(
  patient_id = seq(1, 8), 
  geslacht = c(1, 2, 3, 1, 2, 3, 1, 2),
  commal1 = c(1, 2, 3, 4, 1, 2, 3, 4)
)

data_description <- data %>%
  gather("variables", "value", -patient_id) %>%
  left_join(data_dictionary, by = c("variables" = "column_name", "value")) %>%
  select(-value) %>%
  spread(variables, description)