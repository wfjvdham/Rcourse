

Rmarkdown
========================================================
author: Wim van der Ham
date: 2018-11-02
autosize: true

Ways of Working With R
========================================================

1. Ad Hoc (without a plan) in the console
1. Using R files
1. Using Rmarkdown

Ad Hoc
========================================================

- **Not** reproducible
- **Not** possible to add documentation
- **Not** presentable

R file
========================================================

- Reproducible!
- More or less possible to add documentation
- **Not** presentable, you have to copy your graphs into a presentation

Rmarkdown
========================================================

- Reproducible!
- Easy to add Documentation!
- Presentable!

Structure of a Rmarkdown File
========================================================

1. **[YAML](http://yaml.org/) header** with general information and options
2. **Chunks of R code**
3. **Text** using markdown for markup

Header
========================================================

- Title
- Output format
  - html_document
  - pdf_document
  - word_document
  - odt_document
  - rtf_document
  - github_document

Example
========================================================

Example in `rmarkdown.Rmd`

Rpresentations
========================================================
transition: fade

> Feature of Rstudio to make HTML presentations using a Combination of markdown and R.

[Documentation](https://support.rstudio.com/hc/en-us/sections/200130218-R-Presentations)

Rpresentations
========================================================
transition: fade
type: section

This is a **section**

Rpresentations
========================================================
transition: fade
type: sub-section

Test is a **sub-section**

Rpresentations
========================================================
transition: fade
type: prompt

This is a **prompt**

Rpresentations
========================================================
transition: fade
type: alert

This is a **alert**

Extracting R code from a Markdown file
========================================================


```r
purl(
  "./03_rmarkdown/rmarkdown.Rmd", 
  output = "./03_rmarkdown/test.R", 
  documentation = 2
)
```

Exercise
========================================================

Take your results from the questions about the `flights` data set and put them into a nicely formatted rmarkdown
