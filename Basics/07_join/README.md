join
========================================================
author: Wim van der Ham
width: 1440
height: 900

merge() vs join
========================================================

For joining data frames you can use the `merge()` function from `base` or the join functions from the `dplyr` package. The last ones have the following [advantages](https://groups.google.com/forum/#!topic/manipulatr/OuAPC4VyfIc) above the `merge()` function:

* Rows are kept in existing order
* Much faster
* Tells you what keys you’re merging by (if you don’t supply)
* Also work with database tables

Type of joins
========================================================

![](join-image.jpg)

Join - 1 column
========================================================




```r
flights2 %>% 
  left_join(airlines)
```

```
# A tibble: 20,000 x 7
    year  hour origin dest  tailnum carrier name                    
   <int> <dbl> <chr>  <chr> <chr>   <chr>   <chr>                   
 1  2013    17 LGA    ORD   N27733  UA      United Air Lines Inc.   
 2  2013    14 JFK    BOS   N346NB  DL      Delta Air Lines Inc.    
 3  2013     7 EWR    LAX   N87527  UA      United Air Lines Inc.   
 4  2013     6 JFK    MCO   N307JB  B6      JetBlue Airways         
 5  2013     9 JFK    AUS   N583JB  B6      JetBlue Airways         
 6  2013    17 EWR    BOS   N329JB  B6      JetBlue Airways         
 7  2013    14 JFK    HOU   N298JB  B6      JetBlue Airways         
 8  2013     8 JFK    CLT   N178US  US      US Airways Inc.         
 9  2013    14 EWR    MSP   N744EV  EV      ExpressJet Airlines Inc.
10  2013    15 JFK    PHX   N523UW  US      US Airways Inc.         
# … with 19,990 more rows
```

Join - Multiple columns
========================================================


```r
flights2 %>% 
  left_join(weather)
```

```
# A tibble: 7,262,541 x 18
    year  hour origin dest  tailnum carrier month   day  temp  dewp humid
   <dbl> <dbl> <chr>  <chr> <chr>   <chr>   <dbl> <int> <dbl> <dbl> <dbl>
 1  2013    17 LGA    ORD   N27733  UA          1     1  36.0  17.1  45.8
 2  2013    17 LGA    ORD   N27733  UA          1     2  32    14    46.9
 3  2013    17 LGA    ORD   N27733  UA          1     3  32    14    46.9
 4  2013    17 LGA    ORD   N27733  UA          1     4  37.0  19.9  49.6
 5  2013    17 LGA    ORD   N27733  UA          1     5  41    19.0  40.9
 6  2013    17 LGA    ORD   N27733  UA          1     6  45.0  24.1  43.5
 7  2013    17 LGA    ORD   N27733  UA          1     7  41    21.0  44.5
 8  2013    17 LGA    ORD   N27733  UA          1     8  46.9  30.0  51.6
 9  2013    17 LGA    ORD   N27733  UA          1     9  50    36.0  58.3
10  2013    17 LGA    ORD   N27733  UA          1    10  45.0  25.0  45.2
# … with 7,262,531 more rows, and 7 more variables: wind_dir <dbl>,
#   wind_speed <dbl>, wind_gust <dbl>, precip <dbl>, pressure <dbl>,
#   visib <dbl>, time_hour <dttm>
```

Join - Same columns names
========================================================


```r
flights2 %>% 
  left_join(planes, by = "tailnum")
```

```
# A tibble: 20,000 x 14
   year.x  hour origin dest  tailnum carrier year.y type  manufacturer
    <int> <dbl> <chr>  <chr> <chr>   <chr>    <int> <chr> <chr>       
 1   2013    17 LGA    ORD   N27733  UA        1999 Fixe… BOEING      
 2   2013    14 JFK    BOS   N346NB  DL        2002 Fixe… AIRBUS      
 3   2013     7 EWR    LAX   N87527  UA        2010 Fixe… BOEING      
 4   2013     6 JFK    MCO   N307JB  B6        2009 Fixe… EMBRAER     
 5   2013     9 JFK    AUS   N583JB  B6        2004 Fixe… AIRBUS      
 6   2013    17 EWR    BOS   N329JB  B6        2011 Fixe… EMBRAER     
 7   2013    14 JFK    HOU   N298JB  B6        2009 Fixe… EMBRAER     
 8   2013     8 JFK    CLT   N178US  US        2001 Fixe… AIRBUS INDU…
 9   2013    14 EWR    MSP   N744EV  EV        2004 Fixe… BOMBARDIER …
10   2013    15 JFK    PHX   N523UW  US        2009 Fixe… AIRBUS      
# … with 19,990 more rows, and 5 more variables: model <chr>,
#   engines <int>, seats <int>, speed <int>, engine <chr>
```

Join - Different column names
========================================================


```r
flights2 %>% 
  left_join(airports, by = c("dest" = "faa"))
```

```
# A tibble: 20,000 x 13
    year  hour origin dest  tailnum carrier name    lat    lon   alt    tz
   <int> <dbl> <chr>  <chr> <chr>   <chr>   <chr> <dbl>  <dbl> <int> <dbl>
 1  2013    17 LGA    ORD   N27733  UA      Chic…  42.0  -87.9   668    -6
 2  2013    14 JFK    BOS   N346NB  DL      Gene…  42.4  -71.0    19    -5
 3  2013     7 EWR    LAX   N87527  UA      Los …  33.9 -118.    126    -8
 4  2013     6 JFK    MCO   N307JB  B6      Orla…  28.4  -81.3    96    -5
 5  2013     9 JFK    AUS   N583JB  B6      Aust…  30.2  -97.7   542    -6
 6  2013    17 EWR    BOS   N329JB  B6      Gene…  42.4  -71.0    19    -5
 7  2013    14 JFK    HOU   N298JB  B6      Will…  29.6  -95.3    46    -6
 8  2013     8 JFK    CLT   N178US  US      Char…  35.2  -80.9   748    -5
 9  2013    14 EWR    MSP   N744EV  EV      Minn…  44.9  -93.2   841    -6
10  2013    15 JFK    PHX   N523UW  US      Phoe…  33.4 -112.   1135    -7
# … with 19,990 more rows, and 2 more variables: dst <chr>, tzone <chr>
```
