Unsupervised Learning
========================================================
author: Wim van der Ham
autosize: true

Overview
========================================================

![Overview](./model_schema.jpg)

Unsupervised Learning
========================================================

> Unsupervised learning is used when you do not want to predict anything but want to understand your data better. It is much harder than supervised learning because there is no simple goal.

It answers questions like:

- Is there an informative way to visualize the data? 
- Can we discover subgroups among the variables or among the observations?

Unsupervised Learning
========================================================

In this chapter we will discuss two different techniques:

1. [principal components analysis](https://en.wikipedia.org/wiki/Principal_component_analysis), a tool
used for data visualization or data pre-processing
1. [clustering](https://en.wikipedia.org/wiki/Cluster_analysis), a broad class of methods for discovering
unknown subgroups in data

PCA
========================================================

> Allows to summarize a data set with less variables that still explin most of the variation in the data

When the number of variables in the dataset is big it van be difficult to visualize the data. PCA reduces the number of variables while stil showing most of the variation in the data.

PCA - Example Graph
========================================================

![Two Principal Components Directed allong the Greates Variation](./pca.jpg)

PCA - USA Arrest Example
========================================================

Scaling and centering the variables around zero is required to calculate unbiased components


```r
library(tidyverse)
pca <- prcomp(
  USArrests, 
  center = TRUE, 
  scale. = TRUE
)
```

Plotting the Result - Code
========================================================


```r
library(ggfortify)
autoplot(
  pca, shape = FALSE, 
  label.size = 3,
  loadings = TRUE, loadings.colour = 'blue',
  loadings.label = TRUE, 
  loadings.label.size = 3
)
```

Plotting the Result - Graph
========================================================












```
Error in library(ggfortify) : there is no package called 'ggfortify'
```
