library(nycflights13)
library(tidyverse)

flights_na <- flights %>%
  select_if(~ !any(is.na(.)))

#Cuales columnos tiene valores de NA?
summary(flights)

#Cuantos vuelvos hay el 1 Enero 2013?
flights %>%
  filter(year == 2013 & month == 1 & day == 1) %>%
  nrow

#la distancia más grande en km! y con cual aeropuerto?
flights %>%
  arrange(desc(distance)) %>%
  slice(1) %>%
  mutate(distance_km = distance * 1.60934) %>%
  select(distance_km, dest)

#Cuantos destinos hay?
flights %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  nrow

n_distinct(flights$dest)

#la mediana en la distancia por los vuelos con carries es DL?
flights %>%
  group_by(carrier) %>%
  summarise(medianDistance = median(distance)) %>%
  filter(carrier == "DL") %>%
  select(medianDistance) 

#El destino mas popular en Enero 2013?
flights %>%
  filter(year == 2013 & month == 1) %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  select(dest)

#Mostrar en un gráfico si hay mas vuelos en retraso o a tiempo
flights %>%
  mutate(delayed = arr_delay > 0) %>%
  na.omit %>%
  ggplot() +
  geom_bar(aes(delayed))

if_else(arr_delay > 0, "true", "false")

#Cuales son los tiempos mas populares para salir?
ggplot(flights) +
  geom_histogram(aes(hour), binwidth = 1)

#Que puedes decir sobre la distribucion de arr_deley?
ggplot(flights) +
  geom_histogram(aes(arr_delay)) +
  xlim(-100, 300)
