library(tidyverse)

df <- tibble(
  "jaar" = 1:10 + 2000,
  "regio" = rep(c("AMS", "UTR"), 5),
  "chemneo" = runif(10)
)

check_variable <- function(col_name) {
  from <- as.formula(paste("chemneo ~", col_name))
  model <- glm(from, data = df, family = binomial(link = 'logit'))
  confint_list <- exp(confint(model))
  list(
    "confint" = confint_list,
    "sum_model" = summary(model)
  )
}

result <- check_variable("jaar")

col_names <- colnames(df)[1:2]
result2 <- map(col_names, check_variable)
result2 <- set_names(result2, col_names)
