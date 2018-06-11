library(tidyverse)

pew <- read_csv(
  "./datasets/pew.csv"
)

pew <- pew %>%
  gather(2:11, key = "income", value = "count")

weather <- read_csv("./datasets/weather.csv") %>%
  gather(d1:d31, key = "day", value = "temperature", na.rm = TRUE) %>%
  spread(key = "element", value = "temperature") %>%
  mutate(TMAX = as.numeric(TMAX),
         TMIN = as.numeric(TMIN))

# example of interesting plot for both of them

weather %>%
  group_by(month) %>%
  summarise(avg_min = mean(TMIN),
            avg_max = mean(TMAX)) %>%
  gather(2:3, key="temptype", value="temp") %>%
  ggplot(aes(x=factor(month), y=temp, fill=temptype)) +
  geom_bar(position="dodge", stat="identity") +
  labs(title = "Average min and max temperature per month", x = "month")

unique(pew$income)

pew %>%
  mutate(
    estimated_income = case_when(
      income == "<$10k" ~ 5000,
      income == "$10-20k" ~ 15000,
      income == "$20-30k" ~ 25000,
      income == "$30-40k" ~ 35000,
      income == "$40-50k" ~ 45000,
      income == "$50-75k" ~ 62500,
      income == "$75-100k" ~ 87500,
      income == "$100-150k" ~ 125000,
      income == "$>150k" ~ 200000,
      TRUE ~ NA_real_
    ) * count
  ) %>%
  filter(!is.na(estimated_income)) %>%
  group_by(religion) %>%
  summarise(n_people = sum(count),
            total_estimated_income = sum(estimated_income, na.rm = TRUE)) %>%
  mutate(avg_income = total_estimated_income / n_people) %>%
  ggplot() +
  # geom_bar(aes(fct_reorder(religion, avg_income), avg_income), stat = "identity") +
  # geom_bar(aes(reorder(religion, avg_income), avg_income), stat = "identity") +
  geom_bar(aes(religion, avg_income), stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
