

Shiny Dashboard
========================================================
author: Wim van der Ham
date: 2018-06-29
autosize: true

Shiny Dashboard
========================================================

[Shiny Dashboard](https://rstudio.github.io/shinydashboard/index.html) is a package that makes it easier to make dasboards using shiny.

Run the file `basic_dashboard.R` to see a simple example.

Or run `086-bus-dashboard/ui.R` for a more complicated example.

Structure
========================================================


```r
dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)
```

Icons
========================================================

Does not yet supports Font Awesome version 5 use [version 4](https://fontawesome.com/v4.7.0/)
