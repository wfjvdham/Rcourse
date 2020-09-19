library(tidyverse)
library(tidymodels)
library(plotly)

# get the data

tuesdata <- tidytuesdayR::tt_load('2020-07-07')
coffee <- tuesdata$coffee_ratings

# explore

skimr::skim(coffee)

# Which countries produce the best coffee

coffee_min20 <- coffee %>%
  group_by(country_of_origin) %>% 
  mutate(
    n = n(), 
    average_cupper_points = mean(cupper_points)
  ) %>%
  filter(n > 20) %>%
  mutate(
    country_of_origin = forcats::fct_reorder(country_of_origin, average_cupper_points)
  )

ggplot(coffee_min20) +
  geom_boxplot(aes(
    x = forcats::fct_reorder(country_of_origin, average_cupper_points), 
    y = cupper_points
  )) +
  coord_flip()

coffee_min20 %>%
  plot_ly(
    x = ~country_of_origin,
    y = ~cupper_points,
    split = ~country_of_origin,
    type = 'violin',
    meanline = list(
      visible = TRUE
    )
  )

set.seed(123)
coffee_split <- initial_split(coffee, prop = 0.8)
coffee_train <- training(coffee_split)
coffee_test <- testing(coffee_split)

coffee_recipe <- recipe(coffee_train) %>%
  # Sets the roles of every variable in the data. A variable can have more than
  # one role, but here we’ll call everything either “outcome”, “predictor”, or
  # “support”. tidymodels treats “outcome” and “predictor” variables specially,
  # but otherwise any string can be a role.
  update_role(everything(), new_role = "support") %>% 
  update_role(cupper_points, new_role = "outcome") %>%
  update_role(
    variety, processing_method, country_of_origin,
    aroma, flavor, aftertaste, acidity, sweetness, altitude_mean_meters,
    new_role = "predictor"
  ) %>%
  # nominal is string
  step_string2factor(all_nominal()) %>%
  step_knnimpute(
    country_of_origin,
    impute_with = imp_vars(
      in_country_partner, company, region, farm_name, certification_body
    )
  ) %>%
  step_knnimpute(
    altitude_mean_meters,
    impute_with = imp_vars(
      in_country_partner, company, region, farm_name, certification_body,
      country_of_origin
    )
  ) %>%
  #Convert all missing varieties to an “unknown” value.
  step_unknown(all_nominal(), new_level = "NA") %>%
  step_other(country_of_origin, threshold = 0.01) %>%
  step_other(processing_method, variety, threshold = 0.10) %>% 
  step_normalize(all_numeric(), -all_outcomes())
coffee_recipe

coffee_recipe_bt <- coffee_recipe %>%
  step_dummy(all_predictors(), -all_numeric(), one_hot = TRUE)

coffee_train %>%
  count(processing_method)

coffee_recipe %>% 
  prep(coffee_train) %>%
  bake(coffee_train) %>%
  count(processing_method)

coffee_model_rf <- rand_forest(
  trees = tune(),
  mtry = tune()
) %>%
  set_engine("randomForest") %>% 
  set_mode("regression")
coffee_model_rf

coffee_model_bt <- boost_tree(
  trees = tune(),
  mtry = tune()
) %>%
  set_engine("xgboost") %>%
  set_mode("regression")

coffee_workflow_rf <- workflow() %>% 
  add_recipe(coffee_recipe) %>% 
  add_model(coffee_model_rf)
coffee_workflow_rf

coffee_workflow_bt <- workflow() %>% 
  add_recipe(coffee_recipe_bt) %>% 
  add_model(coffee_model_bt)
coffee_workflow_bt

coffee_grid <- expand_grid(
  mtry = 3:5, 
  trees = seq(100, 1300, by = 200)
)

coffee_folds <- vfold_cv(coffee_train, v = 5)
coffee_folds

coffee_grid_results_rf <- coffee_workflow_rf %>% 
  tune_grid(
    resamples = coffee_folds,
    grid = coffee_grid,
    control = control_grid(verbose = TRUE)
  )

coffee_grid_results_bt <- coffee_workflow_bt %>% 
  tune_grid(
    resamples = coffee_folds,
    grid = coffee_grid,
    control = control_grid(verbose = TRUE)
  )

collect_metrics(coffee_grid_results_rf) %>%
  filter(.metric == "rmse") %>% 
  arrange(mean) %>%
  head()

collect_metrics(coffee_grid_results_bt) %>%
  filter(.metric == "rmse") %>% 
  arrange(mean) %>%
  head()

autoplot(coffee_grid_results_bt, metric = "rmse")

show_best(coffee_grid_results_bt, metric = "rmse")

select_by_one_std_err(coffee_grid_results_bt, metric = "rmse", trees)

fitted_coffee_model_rf <- coffee_workflow_rf %>% 
  finalize_workflow(
    select_by_one_std_err(coffee_grid_results_rf, metric = "rmse", trees)
  ) %>% 
  fit(coffee_train)

fitted_coffee_model_bt <- coffee_workflow_bt %>% 
  finalize_workflow(
    select_by_one_std_err(coffee_grid_results_bt, metric = "rmse", trees)
  ) %>% 
  fit(coffee_train)

fitted_coffee_model_rf %>%
  predict(coffee_test) %>%
  bind_cols(coffee_test) %>%
  metrics(truth = cupper_points, estimate = .pred)

fitted_coffee_model_bt %>%
  predict(coffee_test) %>%
  bind_cols(coffee_test) %>%
  metrics(truth = cupper_points, estimate = .pred)
