library(ggfortify)

df <- iris %>%
  select(-Species)

pca <- prcomp(df, center = TRUE, scale. = TRUE)
autoplot(
  pca, data = iris, colour = 'Species',
  loadings = TRUE, loadings.colour = 'blue',
  loadings.label = TRUE, loadings.label.size = 3
)
