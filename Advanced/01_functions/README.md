Functions
========================================================
author: Wim van der Ham
autosize: true

Why use a Function?
========================================================

1. Reduces the amount of copy-and-paste and thus reducing the amount of mistakes in your code.
1. When something needs to be changed you only need to change it in one place.
1. To give a name to part of your code, making your code easier to read.
1. To pass it to another function as an argument.

**Use a function when you notice you are copy-and-pasting some code a lot**

Elements of a function
========================================================


```r
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))
```

```
[1] 0.0 0.5 1.0
```

1. **Name**, in this case `rescale01`
1. **Arguments**, input of the function, in this case `x`
1. **Body**, code of the function that is between `{` and `}`

Tips for a good name
========================================================

- Use a name that tells what the function is doing
- Use a verb
- Do not use a name that is already used in R

Default values
========================================================

- If no default is given a value **must** be supplied.
- If a default is given no value is required.
  - If no value is given the default is used.
  - If a value is given the value is used.

Default values - Example
========================================================


```r
rescale01 <- function(x, na.rm = TRUE) {
  rng <- range(x, na.rm = na.rm)
  (x - rng[1]) / (rng[2] - rng[1])
}
#rescale01()
rescale01(c(0, 5, 10, NA), TRUE)
```

```
[1] 0.0 0.5 1.0  NA
```

```r
rescale01(c(0, 5, 10, NA), FALSE)
```

```
[1] NA NA NA NA
```

```r
rescale01(c(0, 5, 10, NA))
```

```
[1] 0.0 0.5 1.0  NA
```

Return values
========================================================

- Automatically the result of the last line of the body is returned.
- If you want to return multiple values you have to use a `list()`. It is recommended to give names to the values.

Return values - Example
========================================================


```r
rescale01 <- function(x, na.rm = TRUE) {
  rng <- range(x, na.rm = na.rm)
  result <- (x - rng[1]) / (rng[2] - rng[1])
  list(
    "result" = result, "min_value" = rng[1]
  )
}
rescale01(c(0, 5, 10, NA))
```

```
$result
[1] 0.0 0.5 1.0  NA

$min_value
[1] 0
```

Scoping
========================================================


```r
f <- function(x) {
  x + y
}
x <- 1
y <- 2
#f(3)
```

- For variables in the body of the function R first checks if it is one of the arguments.
- After that is looks in the environment from where the functions is called.

Formula
========================================================

- Simplified version of a function
- 1 line of R code
- Starts with `~`
- Use `.` when there is 1 input agrument




```r
mtcars %>%
  summarise(across(everything(), ~ sum(.) + 10))
```

```
    mpg cyl   disp   hp   drat      wt   qsec vs am gear carb
1 652.9 208 7393.1 4704 125.09 112.952 581.16 24 23  128  100
```
