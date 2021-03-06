Rmarkdown
========================================================
author: Wim van der Ham
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

markdown
========================================================

> A lightweight markup language with plain text formatting syntax

Nice overview of the most important functionalities can be found [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

Header
========================================================

- **`title`** Title of the document
- **`output`** Format of the output file

  - **`html_notebook`** Updates the result automatically after a save. Recomended when starting with the document.
  - **`html_document`** Outputs html which has the same functionality as a `html_notebook`
  - **`pdf_document`** Outputs a pdf
  - **`word_document`** Outputs a word

Code Visability
========================================================

- **No extra options** Shows code and output
- **`include=FALSE`** Shows no code and no output but runs the code. Typically used for loading packages.
- **`echo=FALSE`** Shows only the ouput but not the code
- **`eval=FALSE`** Shows the code but does not run it

Extracting R code from a Markdown file
========================================================


```r
library(knitr)
purl(
  "./03_rmarkdown/rmarkdown.Rmd",
  output = "./03_rmarkdown/test.R",
  documentation = 2
)
```
