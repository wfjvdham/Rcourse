Combining a data dictionairy with a data frame
================

Here an example data dictionary is defined and an example data frame.

``` r
data_dictionary <- tibble(
  column_name = c(rep("geslacht", 3), rep("commal1", 4)),
  value = c(1, 2, 3, 1, 2, 3, 4),
  description = c(
    "Man", "Vrouw", "Ongedifferentieerd", "Ja, actueel",
    "Ja, curatief behandeld < 5j geleden", "Ja, curatief behandeld > 5j geleden",
    "Ja, palliatief behandeld"
  )
)
data_dictionary
```

    ## # A tibble: 7 x 3
    ##   column_name value description                        
    ##   <chr>       <dbl> <chr>                              
    ## 1 geslacht        1 Man                                
    ## 2 geslacht        2 Vrouw                              
    ## 3 geslacht        3 Ongedifferentieerd                 
    ## 4 commal1         1 Ja, actueel                        
    ## 5 commal1         2 Ja, curatief behandeld < 5j geleden
    ## 6 commal1         3 Ja, curatief behandeld > 5j geleden
    ## 7 commal1         4 Ja, palliatief behandeld

``` r
data <- tibble(
  patient_id = seq(1, 8), 
  geslacht = c(1, 2, 3, 1, 2, 3, 1, 2),
  commal1 = c(1, 2, 3, 4, 1, 2, 3, 4)
)
data
```

    ## # A tibble: 8 x 3
    ##   patient_id geslacht commal1
    ##        <int>    <dbl>   <dbl>
    ## 1          1        1       1
    ## 2          2        2       2
    ## 3          3        3       3
    ## 4          4        1       4
    ## 5          5        2       1
    ## 6          6        3       2
    ## 7          7        1       3
    ## 8          8        2       4

Now it is shown how the values in the data frame can be replaced with
the labels in the data dictionairy.

``` r
data_description <- data %>%
  gather("column_name", "value", -patient_id) %>%
  left_join(data_dictionary, by = c("column_name", "value")) %>%
  select(-value) %>%
  spread(column_name, description)
data_description
```

    ## # A tibble: 8 x 3
    ##   patient_id commal1                             geslacht          
    ##        <int> <chr>                               <chr>             
    ## 1          1 Ja, actueel                         Man               
    ## 2          2 Ja, curatief behandeld < 5j geleden Vrouw             
    ## 3          3 Ja, curatief behandeld > 5j geleden Ongedifferentieerd
    ## 4          4 Ja, palliatief behandeld            Man               
    ## 5          5 Ja, actueel                         Vrouw             
    ## 6          6 Ja, curatief behandeld < 5j geleden Ongedifferentieerd
    ## 7          7 Ja, curatief behandeld > 5j geleden Man               
    ## 8          8 Ja, palliatief behandeld            Vrouw
