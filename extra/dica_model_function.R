library(tidyverse)
library(aod)

df <- tibble(
  "jaar" = as.factor(1:10 + 2000),
  "regio" = as.factor(rep(c("AMS", "UTR"), 5)),
  "chemneo" = runif(10)
)

check_variable <- function(df, col_name, terms) {
  table(df[[col_name]], useNA = "always")
  from <- as.formula(paste("chemneo ~", col_name))
  model <- glm(chemneo ~ jaar, data = df, family = binomial(link = 'logit'))
  exp(coef(model))
  confint_list <- exp(confint(model))
  summary(model)
  wald_test <- wald.test(b = coef(model), Sigma = vcov(model), Terms = terms)
  list(
    "confint" = confint_list,
    "H0" = wald_test$H0
  )
}

result <- check_variable(df, "jaar", 6)

col_names <- colnames(df)[1:2]
terms_list <- c(6, 4)

result2 <- map2(col_names, terms_list, ~ check_variable(df, .x, .y))

#------------------------------------------------------------------------------------------------------------------

### Multivariabele analyses

#------------------------------------------------------------------------------------------------------------------

model <- glm(chemneo ~ leefcat + asascore + xbmi + xcharlgrp + xaantaltumor + xtumdiam + xoorsprlev + synchr, data = df, family = binomial(link = 'logit'))
#volume_lever + chemneo + resectievg + synchr + benad + xcommda6b + xcommda6a + geslacht + age + asascore + xcharlgrp + xbmi
exp(coef(model))
exp(confint(model))
summary(model)

walt_terms <- list(
  2, 2:4, 5:6, 7, 8, 8:9, 10:14
)

walt_test_terms <- function(terms) {
  wald.test(b = coef(model), Sigma = vcov(model), Terms = terms) 
}

map(walt_terms, walt_test_terms)

# wald.test(b = coef(model), Sigma = vcov(model), Terms = 2) #geslacht
wald.test(b = coef(model), Sigma = vcov(model), Terms = 2:4) #leefcat
wald.test(b = coef(model), Sigma = vcov(model), Terms = 5:6) #asascore
# wald.test(b = coef(model), Sigma = vcov(model), Terms = 8) #chemneo
wald.test(b = coef(model), Sigma = vcov(model), Terms = 7) #bmi
wald.test(b = coef(model), Sigma = vcov(model), Terms = 8:9) #xcharlgrp
wald.test(b = coef(model), Sigma = vcov(model), Terms = 10:14) #xaantaltumor
wald.test(b = coef(model), Sigma = vcov(model), Terms = 15:18) #xtumdiam
wald.test(b = coef(model), Sigma = vcov(model), Terms = 19) #xoorsprlev
wald.test(b = coef(model), Sigma = vcov(model), Terms = 20) #synchr
wald.test(b = coef(model), Sigma = vcov(model), Terms = 21:23) #synchr

#wald.test(b = coef(model), Sigma = vcov(model), Terms = 20:21) #volumelever
#wald.test(b = coef(model), Sigma = vcov(model), Terms = 35:36) #okecho
# wald.test(b = coef(model), Sigma = vcov(model), Terms = 22) #mrilever
# wald.test(b = coef(model), Sigma = vcov(model), Terms = 23) #petscan
# #wald.test(b = coef(model), Sigma = vcov(model), Terms = 31:44) # xtumor want NA erin, snap niet goed hoe dit kan
# wald.test(b = coef(model), Sigma = vcov(model), Terms = 24:25) #xcharlgr

vif(model)

## Nagelkerke ## nog

library(pscl)

pR2(model) # Nagelkerke = 0.38

## ROC curve - moeilijk met zoveel variabelen.

n <- 3376
x <- rnorm(n)
pr <- exp(x) / (1+exp(x))
y <- 1*(runif(n)<pr)
predpr <-predict(model,type=c("response"))
roccurve <- roc(y ~ predpr)
plot(roccurve)
