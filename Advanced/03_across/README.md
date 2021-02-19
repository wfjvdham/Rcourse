Column-wise operations
========================================================
author: Wim van der Ham
width: 1440
height: 900



Why?
========================================================


```r
iris %>% 
  summarise(
    Sepal.Length = mean(Sepal.Length), 
    Sepal.Width = mean(Sepal.Width), 
    Petal.Length = mean(Petal.Length), 
    Petal.Width = mean(Petal.Width)
  )
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         3.76        1.20
```

Using across()
========================================================


```r
iris %>%
  summarise(across(1:4, mean))
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         3.76        1.20
```

Use different functions
========================================================


```r
iris %>%
  summarise(
    across(1:2, mean),
    across(3:4, sum)
  )
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         564.        180.
```

Only for the numeric columns - where()
========================================================


```r
iris %>%
  summarise(across(where(is.numeric), mean))
```

```
# A tibble: 1 x 4
  Sepal.Length Sepal.Width Petal.Length Petal.Width
         <dbl>       <dbl>        <dbl>       <dbl>
1         5.84        3.06         3.76        1.20
```

Works also with mutate
========================================================


```r
iris %>%
  mutate(across(where(is.numeric), log))
```

```
# A tibble: 150 x 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          <dbl>       <dbl>        <dbl>       <dbl> <fct>  
 1         1.63        1.25        0.336      -1.61  setosa 
 2         1.59        1.10        0.336      -1.61  setosa 
 3         1.55        1.16        0.262      -1.61  setosa 
 4         1.53        1.13        0.405      -1.61  setosa 
 5         1.61        1.28        0.336      -1.61  setosa 
 6         1.69        1.36        0.531      -0.916 setosa 
 7         1.53        1.22        0.336      -1.20  setosa 
 8         1.61        1.22        0.405      -1.61  setosa 
 9         1.48        1.06        0.336      -1.61  setosa 
10         1.59        1.13        0.405      -2.30  setosa 
# … with 140 more rows
```

If you want all columns use everything()
========================================================


```r
mtcars %>%
  mutate(across(everything(), log))
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

Change colnames
========================================================


```r
iris %>%
  group_by(Species) %>%
  mutate(across(1:2, mean, .names = "mean_{.col}"))
```

```
# A tibble: 150 x 7
# Groups:   Species [3]
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species mean_Sepal.Leng…
          <dbl>       <dbl>        <dbl>       <dbl> <fct>              <dbl>
 1          5.1         3.5          1.4         0.2 setosa              5.01
 2          4.9         3            1.4         0.2 setosa              5.01
 3          4.7         3.2          1.3         0.2 setosa              5.01
 4          4.6         3.1          1.5         0.2 setosa              5.01
 5          5           3.6          1.4         0.2 setosa              5.01
 6          5.4         3.9          1.7         0.4 setosa              5.01
 7          4.6         3.4          1.4         0.3 setosa              5.01
 8          5           3.4          1.5         0.2 setosa              5.01
 9          4.4         2.9          1.4         0.2 setosa              5.01
10          4.9         3.1          1.5         0.1 setosa              5.01
# … with 140 more rows, and 1 more variable: mean_Sepal.Width <dbl>
```

all in a filter
========================================================


```r
iris %>% 
  filter(across(where(is.numeric), ~ .x > 2.4))
```

```
# A tibble: 3 x 5
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species  
         <dbl>       <dbl>        <dbl>       <dbl> <fct>    
1          6.3         3.3          6           2.5 virginica
2          7.2         3.6          6.1         2.5 virginica
3          6.7         3.3          5.7         2.5 virginica
```

Any in a filter
========================================================


```r
iris %>%
  filter(if_any(everything(), ~ is.na(.x)))
```

```
# A tibble: 0 x 5
# … with 5 variables: Sepal.Length <dbl>, Sepal.Width <dbl>,
#   Petal.Length <dbl>, Petal.Width <dbl>, Species <fct>
```


```r
iris %>% 
  filter(if_any(where(is.numeric), ~ .x > 7.5))
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
