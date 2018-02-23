

tidy
========================================================
author: Wim van der Ham
date: 2018-02-23
autosize: true

Tidy Data
========================================================

1. Each variable is in a column
1. Each observation is a row
1. Each value is a cell

tidy package
========================================================

1. `gather()` Collapse multiple columns into key-value pairs
1. `spread()` Spread a key-value pair across multiple columns
1. `separate()` Split single column into multiple columns
1. `unite()` Paste together multiple columns ass one

Gather
========================================================

![gather](./gather.jpg)

Spread
========================================================

![spread](./spread.jpg)

Separate
========================================================

![separate](./separate.jpg)

Unite
========================================================

![unite](./unite.jpg)

Example
========================================================

Examples in the `tidy.R` file

Exercise
========================================================

Make the following dataset tidy


```r
library(tidyverse)
weather <- read_tsv(
  "http://stat405.had.co.nz/data/weather.txt"
)
```


```r
pew <- read_tsv(
  "http://stat405.had.co.nz/data/pew.txt"
)
```

Exercise - dplyr and ggplot2
========================================================

Create the following graphs:

1. The average minimum and maximum temperature per month
1. An estimation of the average income per religion

Some tips:
- `geom_bar()` with `position="dodge"``
- `case_when()`
- `sum()`
