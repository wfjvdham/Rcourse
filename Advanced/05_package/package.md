

Creating Packages in R
========================================================
author: Wim van der Ham
date: 2018-09-29
autosize: true

Why Create a Package?
========================================================

> R packages provide a simple and consistent way to distribute R code and documentation

1. Use for functions that you use **yourself** in different projects 
1. Use for functions that are used in your **organisation**
1. Use for functions or data that you want to share with **everybody**

What do you need?
========================================================

- [`devtools`](https://devtools.r-lib.org/) package for package development
- [`roxygen2`](https://github.com/klutometis/roxygen) package for generating documentation

If on windows:

- [RTools](https://cran.r-project.org/bin/windows/Rtools/) windows software to built packages

Optional:

- [`goodpractice`](http://mangothecat.github.io/goodpractice/) package that gives you advise on the quality of your package
- [`testthat`](http://testthat.r-lib.org/) package for writing tests
- [`usethis`](http://usethis.r-lib.org/) package for setting up package configuration and tests

How to start?
========================================================

- Create new project -> select R package between options
- Run the `create()` command directly from the console

Structure
========================================================

- **DESCRIPTION** file, containing general information about the package
- **NAMESPACE** file, file created by `roxygen2` to prevent namespace conflicts
- **R** folder, containing all the R code for the package
- **man** folder, containing the documentation of the package

Filling out the DESCRIPTION file
========================================================

- **Title** descriptive title of your package
- **Version** version number
- **Author** name of the author of the package
- **Maintainer** the maintainer of the package with email (can be a different person than the author)
- **Description** small description of what the package does
- **License** [choose one here](https://choosealicense.com/) or `GPL-3`

Adding Documentation to Functions
========================================================

Every line of `roxygen` documentation starts with `#' `


```r
#' title of the function
#'
#' description of the function
#'
#' @param word description of the parameters pased to the function
#'
#' @return description of what the function returns
#'
#' @examples
#' hello()
#'
#' @export
```

The export line means that this function should be exported and that everybody using this package can access the function

Flow
========================================================

- `devtools::document()`
- `devtools::check()`
- `goodpractice::gp()`
- `devtools::test()`
- `devtools::build()`
- `devtools::install()`

Version Control
========================================================
    
1. Do not keep track at all
1. Periodically save numbered zip files (or *.tar.gz files)
1. Use a formal version control system, like github
