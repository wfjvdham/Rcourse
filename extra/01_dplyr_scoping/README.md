dplyr Scoping
========================================================
author: Wim van der Ham
width: 1440
height: 900

Scoped Functions
========================================================

> By adding `_if`, `_at` or `_all` behind a function you can apply the function to a specific subset of variables

| Suffix | Subset |
| --- | --- |
| `_all` | All variables |
| `_if` | Variables selected based on a condition |
| `_at` | Variables selected using `vars()` |

**<code>vars()</code>** Works in the same way as `select()` used for the `_at` versions of the functions

summarise_all()
========================================================




```r
iris %>%
  summarise_all(mean)
```

```
# A tibble: 1 x 5
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
         <dbl>       <dbl>        <dbl>       <dbl>   <dbl>
1         5.84        3.06         3.76        1.20      NA
```

summarise_if()
========================================================


```r
iris %>%
  summarise_if(is.numeric, mean)
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         3.76        1.20
```

summarise_at()
========================================================


```r
iris %>%
  summarise_at(vars(1:4), mean)
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         3.76        1.20
```

mutate_all()
========================================================

Only works when all columns are `numeric`, therefore we use a different data set.


```r
mtcars %>% 
  mutate_all(log)
```

```
# A tibble: 32 x 11
     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 1  3.04  1.79  5.08  4.70  1.36 0.963  2.80  -Inf     0  1.39 1.39 
 2  3.04  1.79  5.08  4.70  1.36 1.06   2.83  -Inf     0  1.39 1.39 
 3  3.13  1.39  4.68  4.53  1.35 0.842  2.92     0     0  1.39 0    
 4  3.06  1.79  5.55  4.70  1.12 1.17   2.97     0  -Inf  1.10 0    
 5  2.93  2.08  5.89  5.16  1.15 1.24   2.83  -Inf  -Inf  1.10 0.693
 6  2.90  1.79  5.42  4.65  1.02 1.24   3.01     0  -Inf  1.10 0    
 7  2.66  2.08  5.89  5.50  1.17 1.27   2.76  -Inf  -Inf  1.10 1.39 
 8  3.19  1.39  4.99  4.13  1.31 1.16   3.00     0  -Inf  1.39 0.693
 9  3.13  1.39  4.95  4.55  1.37 1.15   3.13     0  -Inf  1.39 0.693
10  2.95  1.79  5.12  4.81  1.37 1.24   2.91     0  -Inf  1.39 1.39 
# … with 22 more rows
```

mutate_if()
========================================================


```r
iris %>% 
  mutate_if(is.double, as.character)
```

```
# A tibble: 150 x 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
   <chr>        <chr>       <chr>        <chr>       <fct>  
 1 5.1          3.5         1.4          0.2         setosa 
 2 4.9          3           1.4          0.2         setosa 
 3 4.7          3.2         1.3          0.2         setosa 
 4 4.6          3.1         1.5          0.2         setosa 
 5 5            3.6         1.4          0.2         setosa 
 6 5.4          3.9         1.7          0.4         setosa 
 7 4.6          3.4         1.4          0.3         setosa 
 8 5            3.4         1.5          0.2         setosa 
 9 4.4          2.9         1.4          0.2         setosa 
10 4.9          3.1         1.5          0.1         setosa 
# … with 140 more rows
```

mutate_at()
========================================================


```r
iris %>% 
  mutate_at(vars(Sepal.Length:Sepal.Width), log)
```

```
# A tibble: 150 x 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          <dbl>       <dbl>        <dbl>       <dbl> <fct>  
 1         1.63        1.25          1.4         0.2 setosa 
 2         1.59        1.10          1.4         0.2 setosa 
 3         1.55        1.16          1.3         0.2 setosa 
 4         1.53        1.13          1.5         0.2 setosa 
 5         1.61        1.28          1.4         0.2 setosa 
 6         1.69        1.36          1.7         0.4 setosa 
 7         1.53        1.22          1.4         0.3 setosa 
 8         1.61        1.22          1.5         0.2 setosa 
 9         1.48        1.06          1.4         0.2 setosa 
10         1.59        1.13          1.5         0.1 setosa 
# … with 140 more rows
```

filter() - Helper Functions
========================================================

* **<code>any_vars()</code>** Defines an expression that must be `TRUE` for any of the columns
* **<code>all_vars()</code>** Defines an expression that must be `TRUE` for all of the columns

For the last two helper functions the `.` refers to the value of the column

filter_all()
========================================================


```r
iris %>% 
  filter_all(any_vars(is.na(.)))
```

```
# A tibble: 0 x 5
# … with 5 variables: Sepal.Length <dbl>, Sepal.Width <dbl>,
#   Petal.Length <dbl>, Petal.Width <dbl>, Species <fct>
```

filter_if()
========================================================


```r
iris %>% 
  filter_if(is.numeric, all_vars(. > 2.4))
```

```
# A tibble: 3 x 5
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species  
         <dbl>       <dbl>        <dbl>       <dbl> <fct>    
1          6.3         3.3          6           2.5 virginica
2          7.2         3.6          6.1         2.5 virginica
3          6.7         3.3          5.7         2.5 virginica
```

filter_at()
========================================================


```r
iris %>% 
  filter_at(vars(1:4), any_vars(. > 7.5))
```

```
# A tibble: 6 x 5
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species  
         <dbl>       <dbl>        <dbl>       <dbl> <fct>    
1          7.6         3            6.6         2.1 virginica
2          7.7         3.8          6.7         2.2 virginica
3          7.7         2.6          6.9         2.3 virginica
4          7.7         2.8          6.7         2   virginica
5          7.9         3.8          6.4         2   virginica
6          7.7         3            6.1         2.3 virginica
```

Other Functions
========================================================

The suffixes also work for `arrange()`, `group_by` and `select()`. But they are outside the scope of this chapter. I recommend reading the documentation of them.
