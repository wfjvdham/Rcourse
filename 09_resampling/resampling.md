

Resampling
========================================================
author: Wim van der Ham
date: 2018-03-19
autosize: true

Resampling
========================================================

> Evaluate the model performance on a different set than the set used to train the model. This way the performance of the model with new data can be assest.

1. Cross-Validation
1. Bootstrap

The Validation Set Approach
========================================================

> Randomly dividing the available set of observations into two parts, a training set and a validation set. The model is fit on the training set, and the fitted model is used on the validation set.

The Validation Set Approach
========================================================

![Validation Set](./validation_set.jpg)

The Validation Set Approach
========================================================

Disadvantages:

1. **Highly variable** score depends a lot on which points ar in the test or in the validation group
2. **Overestimates the test error** because only half of the data is used for training

Leave-One-Out Cross-Validation
========================================================

> Repedatly train model on all but one observation. Test on the one observation left out.

Leave-One-Out Cross-Validation
========================================================

![LOOCV](./LOOCV.jpg)

Leave-One-Out Cross-Validation
========================================================

Advantages:

1. **Low variability** every step you almost use all the data for training
1. **No randomness** every time this method is used the outcome is the same

***

Disadvantages:

1. **Computational expensive** the model has to be fitted *n* times which can be computational expensive (for a lineair model this is not the case)

k-Fold Cross-Validation
========================================================

> Devide the data into *k* groups. Repeadetly train on all but one group and test on the group left out.

k-Fold Cross-Validation
========================================================

![k-Fold CV](./k_fold_cv.jpg)

k-Fold Cross-Validation
========================================================

Advantages:

1. **Better estimate of score** because it is less prone to overfitting
1. **Computational less expensive** you need to fit the model *k* times

Emperically *k* = 5 or *k* = 10 show the best results

Bootstrap
========================================================

> Repeadetly sample your sample with replacement. To quantify the uncertainty of an estimator.


```r
sample(1:10, 10, replace = TRUE)
```

```
 [1] 2 5 5 6 5 6 2 5 3 9
```

Example
========================================================

Examples can be found in the `resample.R` and `bootstrap.Rmd` files.
