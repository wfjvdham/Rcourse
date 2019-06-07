library(tidyverse)
library(aod)

df <- tibble(
  "jaar" = as.factor(1:10 + 2000),
  "regio" = as.factor(rep(c("AMS", "UTR"), 5)),
  "chemneo" = runif(10)
)

check_variable <- function(col_name) {
  table(df[[col_name]], useNA = "always")
  from <- as.formula(paste("chemneo ~", col_name))
  model <- glm(from, data = df, family = binomial(link = 'logit'))
  exp(coef(model))
  confint_list <- exp(confint(model))
  summary(model)
  terms = length(unique(df[[col_name]]))
  wald_test <- wald.test(b = coef(model), Sigma = vcov(model), Terms = terms)
  list(
    "confint" = confint_list,
    "H0" = wald_test$H0
  )
}

result <- check_variable("jaar")

col_names <- colnames(df)[1:2]
result2 <- map(col_names, check_variable)
result2 <- set_names(result2, col_names)
