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
  
Vectors
========================================================

There are two types of vectors:

1. **Atomic vectors**
  - All elements have the same basic type
  - Cannot be named
2. **Lists**
  - Elements can have different types and can be non-basic (like another list)
  - Can be named
  
**Note** data frames are named lists of atomic vectors

Atomic Vectors - Examples
========================================================


```r
c(1, 2, 3)
```

```
[1] 1 2 3
```

```r
c("a", "b", "c")
```

```
[1] "a" "b" "c"
```

***


```r
c(1, 2, TRUE)
```

```
[1] 1 2 1
```

```r
c(1, 2, "TRUE")
```

```
[1] "1"    "2"    "TRUE"
```

List - Examples
========================================================


```r
list(
  "b", TRUE, 
  list(2, "a")
)
```

```
[[1]]
[1] "b"

[[2]]
[1] TRUE

[[3]]
[[3]][[1]]
[1] 2

[[3]][[2]]
[1] "a"
```

***


```r
list("var1" = 5, "var2" = 6)
```

```
$var1
[1] 5

$var2
[1] 6
```

List - Get Values
========================================================




```r
my_list
```

```
$var1
[1] 5

$var2
[1] 6

$var3
[1] 7
```

```r
my_list[1:2]
```

```
$var1
[1] 5

$var2
[1] 6
```

***


```r
my_list[[1]]
```

```
[1] 5
```

```r
my_list[["var2"]]
```

```
[1] 6
```

```r
my_list$var3
```

```
[1] 7
```

List - Set Names
========================================================




```r
names <- c("var1", "var2", "var3")
data <- c(1, 2, 3)
named_list <- data %>%
  set_names(names)
named_list
```

```
var1 var2 var3 
   1    2    3 
```

List - Other Functions
========================================================


```r
number_list <- c(10, 250, 3)
length(number_list)
```

```
[1] 3
```

```r
sort(number_list)
```

```
[1]   3  10 250
```

```r
sort(number_list, decreasing = TRUE)
```

```
[1] 250  10   3
```

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

Use map
========================================================

1. Do it for one
1. Put it into a function (or a formula)
1. Do it for all using `map()`

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

# Do it for all
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

- `walk()` does not give an output
- `map2()` for iterating over two lists
- `pmap()` for iterating over multiple list. Can be used to apply a function to every row in a data frame

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
[1] 0.09903273
```

```r
pmap(df, runif)
```

```
[[1]]
[1] 0.9904967

[[2]]
[1] 34.81284 71.91306

[[3]]
[1] 843.4982 248.3160 789.9460
```
