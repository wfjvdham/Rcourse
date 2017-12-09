library(nycflights13)
library(tidyverse)
library("ggplot2")
library(bloom)
flights <- as_data_frame(flights)

?flights

# primer ejercicio
flightsna <- flights[, colSums(is.na(flights)) > 0]
summary(flights)
colnames(flights)[colSums(is.na(flights)) > 0]

# segundo ejercicio
flights %>%
  group_by(month) %>%
  filter(year == 2013) %>%
  summarise(n = n())

#tercer ejercicio
#4983 -- Agregar select y agrupar el destino con columna DEST

result <- filter(flights,flights$distance == max(flights$distance))

#Segundo grupo de ejercicios
#primer ejercicio media
flightscarrier  <- filter(flights,flights$carrier == "DL")
median(flightscarrier$distance)

#segundo ejercicio
flights %>%
  group_by(dest) %>%
  filter(year == 2013,month == 1) %>%
  summarise(n = n()) %>%
  #mutate(cant = n()) %>%
  arrange(desc(n)) %>%
  #select(dest,n) %>% #no es necesario ya que se tienen solo dos columnas en la seleccion
  slice(1)

#tercer ejercicio
flights %>%
  filter(arr_delay >= 0) %>%
  summarise(n = n())

flights %>%
  filter(arr_delay < 0) %>%
  summarise(n = n())

flights <- flights %>%
  mutate(retrasado = arr_delay >= 0)

ggplot(flights) + 
  geom_bar(aes(retrasado))

#cuarto ejercicio

ggplot(flights) + 
  geom_bar(aes(hour))

ggplot(flights) + 
  geom_bar(aes(hour,size = 10)) +
  xlim(0,10)

ggplot(flights,aes(hour)) + 
  geom_histogram(binwidth = 0.5)

flights %>%
  group_by(hour) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1:10)


#predecir retrazos
lm(arr_delay ~ dep_delay,data = flights)
mod <- lm(arr_delay ~ dep_delay,data = flights)
summary(mod)

mod_origin <- lm(arr_delay ~ dep_delay + origin,flights)
summary(mod_origin)

anova(mod_origin,mod)
glance(mod_origin)
