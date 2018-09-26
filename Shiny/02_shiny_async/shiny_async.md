

Shiny Async
========================================================
author: Wim van der Ham
date: 2018-06-13
autosize: true

Async Programming
========================================================

R performs tasks one at the time (single threaded)

So when R does a complex calculation you cannot do anything else

Using **async programming** you start the task in a separate thread and can continue doing other things

Launch Tread
========================================================

* For launching asynchronous tasks you can use the [`future`](https://cran.r-project.org/web/packages/future/index.html) package

* For accessing the results of the task asynchronous you can use the [`promises`](https://rstudio.github.io/promises/) package like in `JavaScript`

Promise
========================================================

* Knows is the task is *running*, *failed* or *succeeded*
* If the task is *succeeded* it also knows the result

Promise - Syntax
========================================================

**Synchronous**


```r
query_db() %>%
  filter(cyl > 4) %>%
  head(10) %>%
  View()
```

**Asynchronous**


```r
future(query_db()) %...>%
  filter(cyl > 4) %...>%
  head(10) %...>%
  View()
```

Detecting slow Functions
========================================================

[`profvis`](https://rstudio.github.io/profvis/) package


```r
library(profvis)

profvis({
  data(diamonds, package = "ggplot2")

  plot(price ~ carat, data = diamonds)
  m <- lm(price ~ carat, data = diamonds)
  abline(m, col = "red")
})
```

Calling slow Functions with future()
========================================================

**Synchronous**


```r
data <- reactive({
  read_csv("big.csv")
})
```
**Asynchronous**


```r
data <- reactive({
  future({
    read_csv("big.csv")
  })
})
```

Promise-pipe pattern
========================================================

**Synchronous**


```r
data() %>%
  filter(cyl > 4) %>%
  head(10) %>%
  View()
```

**Asynchronous**


```r
data() %...>%
  filter(cyl > 4) %...>%
  head(10) %...>%
  View()
```

Gather pattern for multiple promises
========================================================

**Synchronous**


```r
data() %>%
  inner_join(whales(), "ip_id") %>%
  head(10) %>%
  View()
```

**Asynchronous**


```r
promise_all(d = data(), w = whales()) %...>% with({
  d %>%
    inner_join(w, "ip_id") %>%
    head(10) %>%
    View()
})
```

Promise-pipe + code block
========================================================

**Synchronous**


```r
data() %>%
  ggplot() +
  geom_bar(aes(ip_name, n), stat = "identity")
```

**Asynchronous**


```r
data() %...>% {
  data_df <- .
  ggplot(data_df) +
  geom_bar(aes(ip_name, n), stat = "identity")
}
```

Do Work in the Future
========================================================

Transferring a lot of data back takes time. Therefore it is better to do as much as possible the calculations in the `future()` function and return only the results.

Exersice
========================================================

In the `app.R` file you find a slow shiny app. Try to make it faster by using `promises` and the `future()` function around the slow part of the app. 
