

Feature Selection
========================================================
author: Wim van der Ham
date: 2018-05-27
autosize: true

Feature Selection
========================================================

1. **Subset Selection** Using least squares regression for different groups of variables
1. **Shrinkage** Using a different formula to make the fit

Best Subset Selection
========================================================

> Calculate for all different configurations of variables the error and pick the best

Cumputationally complex, with 7 variables you need to calculate the error for $2^7=128$ models 

Stepwise Selection
========================================================

**Forward**

> Start with an empty model and repaetedly add the new variable that improves the score the most

**Backward**

> Start with all the variables and repeatedly remove the variable that decreases the score the least

Both do not necessarily lead to the most optimal selection

Selecting the Best Model per Step
========================================================

$R^2$ is always the lowest for the model with all the predictors, therefor the test error needs to be estimated. This can be done in two ways:

1. Use the adjusted $R^2$
1. Calculate the test error using Cross-Validation

Ridge Regression
========================================================

> Calculates the coeficients by using a slightly different formula than the least squares. This formula adds a penalty for the size of the coeficient, so the coeficients tend to go to 0.

The Lasso
========================================================

> Calculates the coeficients by using a slightly different formula than the least squares. This formula adds a penalty for the number of coeficients, so it will set coeficients to 0. So actual variable selection is performed.

Selecting the Tuning Parameter
========================================================

Use Cross-Validation to select the best score and the corresponding tuning parameter.

Examples
========================================================

Examples can be found in the `feature_selection.R` file.
