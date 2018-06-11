

R_Hub
========================================================
author: Wim van der Ham
date: 2018-06-11
autosize: true

Building Packages
========================================================

When building a package R-Hub can be used. The service can be acces in two ways:

1. Using the [website](https://builder.r-hub.io/)
1. Using the `rhub` package

rhub Package
========================================================

* **`platforms()`** shows the available platforms for building the package
* **`validate_email()`** validates your email adres so you can start building
* **`list_validated_emails()`** shows all the validated emails
* **`check()`** to build the package
* **`last_check()`** shows current status of the check

check()
========================================================

* Uses the maintainer email from the description file
* Can use escape to continue with other things in R, the check does not stop
* You will receive an email when the built is finished

More Specific Checks
========================================================

`check_for_cran()` does the required checks for a CRAN submission
`check_on_*` shortcut

Get Last Checks
========================================================

`list_my_checks()` shows the 20 last checks 

* Can be of a specific package by using the package argument
* Can be saved in an object and more calls can be done
  * `livelog()` shows the last livelog
  * `ls()` shows details

Local Debugging
========================================================

For local debugging the r-hub docker image can be downloaded from [docker hub](https://hub.docker.com/u/rhub/)
