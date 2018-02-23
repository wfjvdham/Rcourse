library(tidyverse)

#tidyr examples
who = as_data_frame(tidyr::who)

#gather all the columns with treathments codes
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1

#count them to identify the structure
who1_count <- who1 %>% 
  count(key)

#rename the newrel column to make column names consistent
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

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
weather <- read_tsv(
  "http://stat405.had.co.nz/data/weather.txt"
)
pew <- read_tsv(
  "http://stat405.had.co.nz/data/pew.txt"
)
