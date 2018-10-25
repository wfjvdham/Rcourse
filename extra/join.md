Joining Data Frames
================

For joining data frames you can use the `merge()` function of the join
functions from the `dplyr` package. The last ones have the following
advantages\[1\] above the `merge()` function:

  - rows are kept in existing order
  - much faster
  - tells you what keys you’re merging by (if you don’t supply)
  - also work with database tables.

Good examples can be found
[here](https://dplyr.tidyverse.org/articles/two-table.html)

Overview picture:

![](join-image.jpg)

1.  See
    [here](https://groups.google.com/forum/#!topic/manipulatr/OuAPC4VyfIc)
