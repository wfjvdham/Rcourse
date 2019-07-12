library(nycflights13)
library(tidyverse)
flights <- as_data_frame(flights)

has_na <- function(x) {
  any(is.na(x))
}

tmp <- flights %>% 
  summarise_all(has_na)

flights_na <- flights %>%
  select_if(~ any(is.na(.)))

#Cuales columnos tiene valores de NA?
summary(flights)

#Cuantos vuelvos hay el 1 Enero 2013?
flights %>%
  filter(year == 2013, month == 1, day == 1) %>%
  nrow()

#la distancia más grande en km! y con cual aeropuerto?
flights %>%
  arrange(desc(distance)) %>%
  slice(1) %>%
  mutate(distance_km = distance * 1.60934) %>%
  select(distance_km, origin, dest)

#Cuantos destinos hay?
flights %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  nrow()

n_distinct(flights$dest)

#la mediana en la distancia por los vuelos con carries es DL?
flights %>%
  group_by(carrier) %>%
  summarise(medianDistance = median(distance)) %>%
  filter(carrier == "DL") %>%
  pluck("medianDistance") 

#El destino mas popular en Enero 2013?
flights %>%
  filter(year == 2013 & month == 1) %>%
  group_by(dest) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pluck("dest")

#Mostrar en un gráfico si hay mas vuelos en retraso o a tiempo
flights %>%
  mutate(delayed = arr_delay > 0) %>%
  ggplot() +
  geom_bar(aes(delayed))

flights %>%
  mutate(delayed = if_else(arr_delay > 0, "vertraagd", "niet vertraagd")) %>%
  na.omit() %>%
  ggplot() +
  geom_bar(aes(delayed))

#Cuales son los tiempos mas populares para salir?
ggplot(flights) +
  geom_histogram(aes(hour), binwidth = 1)

#Que puedes decir sobre la distribucion de arr_deley?
ggplot(flights) +
  geom_histogram(aes(arr_delay)) +
  xlim(-100, 300)
