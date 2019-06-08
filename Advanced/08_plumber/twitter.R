# go to https://apps.twitter.com/ to get your keys

# devtools::install_github("geoffjentry/twitteR")
library(twitteR)
library(wordcloud)
library(wordcloud2)
library(tidyverse)
library(config)

config <- config::get(file = "Advanced/06_plumber/config.yml")

setup_twitter_oauth(
  config$api_key, 
  config$api_secret, 
  config$access_token, 
  config$access_token_secret
)

list_of_tweets <- searchTwitter("trump") %>%
  map(~ .x$text) %>%
  paste() %>%
  str_split(" ") 
freq_table <- do.call("rbind", list_of_tweets) %>%
  as_data_frame() %>%
  gather(source, word) %>%
  count(word)

wordcloud(freq_table$word, freq_table$n)

wordcloud2(freq_table)
