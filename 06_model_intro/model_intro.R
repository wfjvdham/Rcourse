library(tidyverse)
set.seed(1)
# Foundation for inference

results <- data_frame(
  cat = c("control", "treatment"),
  buy = c(56, 41),
  not_buy = c(19, 34)
)
results

p_not_buy_c <- 19 / (19 + 56)
p_not_buy_t <- 34 / (34 + 41)
diff <- p_not_buy_t - p_not_buy_c

# What is the probability that this difference is due to chance?

n_total <- sum(results$not_buy, results$buy)
p_buy <- sum(results$buy) / n_total

# simulate using this p

n <- 1000
p_sim <- seq(0, 0, n)
for(i in 1:n) {
  sim_not_buy <- sample(c(0,1), 53, replace = TRUE)
  n_not_buy_t <- sum(sim_not_buy)
  n_not_buy_c <- 53 - n_not_buy_t
  p_sim[i] <- n_not_buy_t / 75 - n_not_buy_c / 75
}
p_sim_df <- as_data_frame(p_sim)

ggplot(p_sim_df) +
  geom_histogram(aes(value)) +
  geom_vline(xintercept = diff)

sum(p_sim_df >= diff) / n * 100

# Applying the normal model

# Check for normality
# 1. No contact between groups so indipendent (or less than 10% of the population)
# 2. At least 10 succes and 10 failures?

(p_not_buy_t * 75) > 10
((1 - p_not_buy_t) * 75) > 10
(p_not_buy_c * 75) > 10
((1 - p_not_buy_c) * 75) > 10

# So yes nearly normal

SE = sqrt((p_not_buy_t * (1 - p_not_buy_t)) / 75 + 
          (p_not_buy_c * (1 - p_not_buy_c)) / 75)

x <- seq(-0.3, 0.3, by = .01)

ggplot() +
  geom_histogram(aes(value), p_sim_df) +
  geom_vline(xintercept = diff) +
  geom_point(aes(x, dnorm(x, mean = 0, sd = SE) * (1 - p_buy) * 75), color = "red")

Z = (0.2 - 0) / SE

(1 - pnorm(Z, mean = 0, sd = 1)) * 2

# p-values are small so H0 is rejected

# chi-square

# Are people in juries representative for a population?

# counts <- data_frame(
#   white = c(205,  198),
#   black = c(26, 19.25),
#   hispanic = c(25, 33),
#   other = c(19, 24.75)
# )
counts <- data_frame(
  observed = c(205, 26, 25, 19),
  expected = c(198, 19.25, 33, 24.75)
)

# Are conditions met for chi-square?
# Independent? Yes
# Every group minimal 5? Yes
# df >= 2? Yes

Z1 <- (205 - 198) / sqrt(198)
Z2 <- (26 - 19.25) / sqrt(19.25)
Z3 <- (25 - 33) / sqrt(33)
Z4 <- (19 - 24.75) / sqrt(24.75)

X2 <- Z1^2 + Z2^2 + Z3^2 + Z4^2

# df = number of bins - 1
df <- 4 - 1
pchisq(2.9877, 3, lower.tail = F)

library(titanic)
train = as_data_frame(titanic_train)
test = as_data_frame(titanic_test)

#example precision & recall
# verdad: 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
# model1: 1, 1, 1, 1, 1, 1, 1, 1, 1, 1  P:0.5 R:1
# model2: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  P:0   R:0
# model3: 1, 1, 1, 1, 1, 0, 0, 0, 0, 0  P:1   R:1

# titanic - model - all death
ggplot(train) +
  geom_bar(aes(factor(Survived)))

train <- train %>%
  mutate(predSurvived = 0)

table(train$predSurvived, train$Survived)

sum(train$predSurvived == train$Survived) / nrow(train)

#titanic - model - male death, female alive
ggplot(train) +
  geom_bar(aes(factor(Survived))) +
  facet_wrap(~Sex)

train <- train %>%
  mutate(predSurvived = ifelse(Sex == "male", 0, 1))

table(train$predSurvived, train$Survived)
sum(train$predSurvived == train$Survived) / nrow(train)

#titanic - model - female and childeren survive rest death
train <- train %>%
  mutate(Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age),
         predSurvived = ifelse(Sex == "female", 1, 0),
         predSurvived = ifelse(Age < 7, 1, predSurvived))

table(train$predSurvived, train$Survived)
sum(train$predSurvived == train$Survived) / nrow(train)
