#httr::set_config( httr::config( ssl_verifypeer = 0L ) )
#devtools::install_github('hadley/ggplot2')
library(ggplot2)
library(plotly)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(p)

library(titanic)
titanic_train <- titanic_train
p <- ggplot(titanic_train) +
  geom_point(aes(Fare, Age, fill = factor(Sex)))
ggplotly(p)
