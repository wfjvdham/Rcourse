

lubridate
========================================================
author: Wim van der Ham
date: 2018-06-18
autosize: true

Dates and Times in R
========================================================

Dates and Times are [implemented](https://www.stat.berkeley.edu/~s133/dates.html) in base R using the `POSIXct` and `POSIXlt` classes and the `as.Date()` function. But those are difficult to use and understand, luckily there is also...

The lubridate Package
========================================================

[`lubridate`](https://lubridate.tidyverse.org/) is a package, which makes it easier to work with dates and times in R. 

It is installed when `tidyverse` is installed, but not automatically loaded. So `library(lubridate)` is required.

Has 3 types of date/time data:

1. A **date**. Tibbles print this as `<date>`.
1. A **time** within a day. Tibbles print this as `<time>`.
1. A **date-time** is a date plus a time: it uniquely identifies an instant in time (typically to the nearest second). Tibbles print this as `<dttm>`. 

Today and Now
========================================================


```r
today()
```

```
[1] "2018-06-18"
```

```r
now()
```

```
[1] "2018-06-18 13:56:43 CEST"
```

Components
========================================================

Abbreviation | Component | Get/set | Periods
--- | --- | --- | ---
**y** | year | `year()` | `years()`
**m** | month | `month()` | `months()`
**d** | day | `mday()`, `wday()` or `yday()` | `days()`
**h** | hour | `hour()` | `hours()`
**m** | minute | `minute()` | `minutes()`
**s** | second | `second()` | `seconds()`
**tz** | timezone | `tz()` | 

From a String - Date
========================================================


```r
ymd("2017-01-31")
```

```
[1] "2017-01-31"
```

```r
mdy("January 31st, 2017")
```

```
[1] "2017-01-31"
```

```r
dmy("31-Jan-2017")
```

```
[1] "2017-01-31"
```

***


```r
ymd(20170131)
```

```
[1] "2017-01-31"
```

From a String - Date-Time
========================================================


```r
ymd_hms("2017-01-31 20:11:59")
```

```
[1] "2017-01-31 20:11:59 UTC"
```

```r
mdy_hm("01/31/2017 08:01")
```

```
[1] "2017-01-31 08:01:00 UTC"
```

```r
ymd(20170131, tz = "UTC")
```

```
[1] "2017-01-31 UTC"
```

make_datetime()
========================================================

> Function to create dates from numeric values




```r
flights %>% 
  mutate(
    departure = make_datetime(
      year, month, day, hour, minute
    )
  ) %>%
  select(departure) %>% 
  slice(1)
```

```
# A tibble: 1 x 1
  departure          
  <dttm>             
1 2013-01-01 05:15:00
```

Unix Epoch
========================================================

> The number of seconds since 1970-01-01 00:00:00 UTC


```r
as_datetime(60 * 60 * 10)
```

```
[1] "1970-01-01 10:00:00 UTC"
```

Periods
========================================================


```r
seconds(15)
```

```
[1] "15S"
```

```r
minutes(10)
```

```
[1] "10M 0S"
```

```r
hours(c(12, 24))
```

```
[1] "12H 0M 0S" "24H 0M 0S"
```

***


```r
days(7)
```

```
[1] "7d 0H 0M 0S"
```

```r
years(1)
```

```
[1] "1y 0m 0d 0H 0M 0S"
```

```r
months(1:3)
```

```
[1] "1m 0d 0H 0M 0S" "2m 0d 0H 0M 0S" "3m 0d 0H 0M 0S"
```

Periods - Calculations
========================================================


```r
10 * (months(6) + days(1))
```

```
[1] "60m 10d 0H 0M 0S"
```

```r
days(50) + hours(25) + minutes(2)
```

```
[1] "50d 25H 2M 0S"
```

```r
ymd("2016-01-01") + years(1)
```

```
[1] "2017-01-01"
```

Exercise
========================================================

An exercise can be found in the `lubridate.Rmd` file.
