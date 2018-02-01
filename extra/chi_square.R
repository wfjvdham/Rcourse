# chi-square

# Are people in juries representative for a population?

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
