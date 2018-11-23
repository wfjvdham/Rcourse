library(tidyverse)
library(stringr)

#tidyr examples
who <- as_data_frame(tidyr::who)

#gather all the columns with treathments codes
who1 <- who %>% 
  gather("key", "value", new_sp_m014:newrel_f65, na.rm = TRUE)
who1

#count them to identify the structure
who1_count <- who1 %>% 
  group_by(key) %>%
  summarise(n = n())

#rename the newrel column to make column names consistent
who2 <- who1 %>% 
  mutate(key = str_replace(key, "newrel", "new_rel"))
who2

# shortcut for counting groups
who2_count <- who2 %>% 
  count(key)

#seperate the key value into columns
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

#check if new has variation?
who3 %>% 
  count(new)

#drop column that do not have information
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

#split segage into sex and age
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5
#who5 is tidy! For modeling we could transform all the columns (except cases) to factors

#make tidy the next two datasets
weather <- read_csv(
  "./datasets/weather.csv"
)
pew <- read_csv(
  "./datasets/pew.csv"
)

# What to do to remove the message when loading the data?
weather <- read_csv(
  "./datasets/weather.csv",
  col_types = list(.default = col_integer(),
                   id = col_character(),
                   element = col_character())
)

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
