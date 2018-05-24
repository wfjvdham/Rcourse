

TensorFlow
========================================================
author: Wim van der Ham
date: 2018-05-24
autosize: true

What is TensorFlow?
========================================================

- General purpose numerical computing library (but used a lot for neural networks)
- Not all data has to be in RAM
- Can distribute computions over different hardware
- Fast low level computations **c++**
- R can be really usefull as an interface

Keras API
========================================================

> High level packages for interfacing TensorFlow

Why use TensorFlow?
========================================================

1. Works best for complex perceptual problems:
  - Vision
  - Speech
1. Can handle large amounts of data

Why use the Cloud for Computing?
========================================================

1. Your data is in the cloud
1. You need more computation resources for a short or longer time
1. You need fast computation

Which services can you use?
========================================================

Full control over the machine using `tfruns`

- [Paperspace](https://www.paperspace.com/)
- [Amazon AWS](https://aws.amazon.com)

Only trains your model and gives back the results, no control over the machine using `cloudml`

- [Google ML](https://cloud.google.com/products/machine-learning/)

tfruns::training_run()
========================================================

Use `training_run()` to keep track of your experimentation

After that you can use

- `ls_runs()` to view all the runs you did
- `view_run()` to view one specific run
- `compare_run()` to compare runs with eachother

tfruns::flags()
========================================================

1. Use `flags()` to create a list of parameters that are used in the model. 
1. For different runs a different flag list can be given as argument in  the `training_run()` function 
1. After the different runs can be compared.

cloudml
========================================================

1. Use `cloudml::cloudml_train()`. Simular to `tfruns::training_run()` only have to supply a `master_type` to specify the machine that will be used.
1. Use `cloudml::cloudml_train()` with a config.yml file for tuning
1. `cloudml::job_trails()` ~ `tsruns::ls_runs()`
1. `cloudml::job_collect()` ~ `tsruns::view_run()`
