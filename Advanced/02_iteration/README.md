Iteration
========================================================
author: Wim van der Ham
autosize: true

Benefits of less copy-and-paste
========================================================

1. Code becomes more readable.
1. Changes only need to be made at one place.
1. Less code means less possibilities for mistakes.

Functional Programming
========================================================

The paradigm that a function can be passed as an argument to another function.

map function
========================================================

> For each element of `.x` do `.f`


```r
map(.x, .f)
```

**.x**

  - a vector
  - a list
  - a data frame (for each column)
  
**.f**

  - a function
  - a formula
  
map function - Example
========================================================




```r
vec <- c("apple", "banana", "melon")

# Do it for 1
nchar(vec[[1]])
```

```
[1] 5
```

```r
# Put it into a function
count_char <- function(x) {
  nchar(x)
}

# Use map
map(vec, count_char)
```

```
[[1]]
[1] 5

[[2]]
[1] 6

[[3]]
[1] 5
```

map family
========================================================

- `map()` makes a list.
- `map_lgl()` makes a logical vector.
- `map_int()` makes an integer vector.
- `map_dbl()` makes a double vector.
- `map_chr()` makes a character vector.
- `map_df()` makes a data frame.

Extra map functions
========================================================

- `walk` does not give an output
- `map2` for iterating over two lists
- `pmap` for iterating over multiple list. Can be used to apply a function to every row in a data frame

pmap example
========================================================


```r
df <- tribble(
  ~ n, ~ min, ~ max,
   1L,     0,     1,
   2L,    10,   100,
   3L,   100,  1000
)

x <- df[1, ]
runif(n = x$n, min = x$min, max = x$max)
```

```
[1] 0.1946338
```

```r
pmap(df, runif)
```

```
[[1]]
[1] 0.8926978

[[2]]
[1] 66.22239 18.82304

[[3]]
[1] 480.4674 612.2684 845.2644
```
