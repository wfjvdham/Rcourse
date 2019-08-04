# Put the values in the data dictionairy on the correct places in the data
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
