

Shiny Load Testing
========================================================
author: Wim van der Ham
date: 2018-09-29
autosize: true

Software
========================================================

R package:

- [`shinyloadtest`](https://github.com/rstudio/shinyloadtest) for recording and analysis

Command Line Tool:

- [`shinycannon`](https://github.com/rstudio/shinycannon) for creating load

Record typical use of the App
========================================================


```r
library(shinyloadtest)
record_session("http://127.0.0.1:7683")
```

Results of the recorded session are stored by default in `recording.log`

Create Benchmark with one Worker
========================================================

Run from the terminal:


```bash
shinycannon recording.log "http://127.0.0.1:5008" --workers 1 --loaded-duration-minutes 4 --output-dir run1
```

Load Results in R
========================================================


```r
test_results <- load_runs("run1")
```

Loading multiple results is possible:


```r
test_results <- load_runs("Run 1" = "run1", "Run 2" = "run2")
```

Create a nice report from the results:


```r
shinyloadtest_report(test_results)
```

Optimize your App
========================================================

1. Add more resources
1. Profile your app and improve code
