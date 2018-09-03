chi-square
================

We have a dataset that contains the number of people in juries for
different ethnic groups.

``` r
counts <- data_frame(
  observed = c(205, 26, 25, 19),
  expected = c(198, 19.25, 33, 24.75)
)
counts
```

    ## # A tibble: 4 x 2
    ##   observed expected
    ##      <dbl>    <dbl>
    ## 1      205    198  
    ## 2       26     19.2
    ## 3       25     33  
    ## 4       19     24.8

The observed values are the number of people in juries for four
different ethnic groups. The expected values are the values that are
expected based on the ratio of the groups in the total population.

Using the chi-square test we can determine if the observation is
significantly different that the population. First some conditions must
be met:

  - Are the groups independent?
  - Every group has minimal 5 observations?
  - The number of groups is more than 2?

First we calculate the *Z* values for every group.

``` r
Z1 <- (205 - 198) / sqrt(198)
Z2 <- (26 - 19.25) / sqrt(19.25)
Z3 <- (25 - 33) / sqrt(33)
Z4 <- (19 - 24.75) / sqrt(24.75)
```

Than we calculate x^2

``` r
X2 <- Z1^2 + Z2^2 + Z3^2 + Z4^2
X2
```

    ## [1] 5.88961

We calculate df using the formula df = number of groups -1

``` r
df <- 4 -1
pchisq(X2 / 2, df, lower.tail = F)
```

    ## [1] 0.4002137

This number is bigger than 0,05 so there is no significant difference
between the observed and expected values
