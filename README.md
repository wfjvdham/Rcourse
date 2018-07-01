# Course for Learning R

## Content

This repository contains the material to learn about the R programming language. The topics are divided in four parts:

* **Basics** starting point if you have few or zero experience with R. The basic concepts are explained here.

  1. Introduction about me, R and this course
  1. Exploring data using the `ggplot2` and `dplyr` packages
  1. Presenting results using the `rmarkdown` package
  1. More exercises about exploring data
  1. Transforming data to a tidy format using the `tidy` package
  1. Make calculations with times and dates using the `lubridate` package
  1. Reading data from a file into R using the `readr` package, or connect to a database using the `DBI` package
  1. An introduction into statistical models
  1. Making a simple linear model
  1. Making a simple logistic regression model
 
* **ML** here more advanced techniques for modeling a dataset are explained

  1. Explanation of re sampling techniques like cross validation and bootstrapping
  1. Automatic feature selection
  1. Decision trees and random forests
  1. More examples for modeling and the Simpsons paradox
 
* **Big Data** explanation of what is big data, hadoop and spark and how to use it in combination with R

  1. Introduction to Big Data
  1. Introduction to Hadoop, MapReduce ans Spark
  1. Introduction to the `sparklyr` package
  1. Introduction to Cloudera
 
* **Advanced** here more advanced R topics are explained

  1. Functional programming using the `purrr` package
  1. Making interactive web pages using `shiny`
  1. Using asynchronous programming in a `shiny` application
  1. Scraping information from an internet page using the `rvest` package

## How to Use

Every chapter has the following parts:

- An `{chapter_name}.md` file that contains the presentation used for the chapter
- An `*.R` or `*.Rmd` file that contains the exercises for the chapter

In the `answers` map all the answers for the exercises can be found. The `extra` folder contains examples that are not closely related to one of the chapters, or new chapters that are beeing made. The `datasets` folder contains the external datasets that are used during this course. Because I gave this course first in Colombia there is also a `presentaciones_en_español` folder with the presentations in Spanish for most of the material. Finally there is a `references.md` file which contains all the sources I used for creating this material.
