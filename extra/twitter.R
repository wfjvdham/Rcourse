# go to https://apps.twitter.com/

# install.packages(c("devtools", "rjson", "bit64", "httr"))

library(devtools)
# install_github("geoffjentry/twitteR")
library(twitteR)
library(wordcloud)
library(wordcloud2)
library(tidyverse)

api_key <- "26UFPC5d9qHwTVoCghF2inwuU"
api_secret <- "aiNyVESpmBeiUh2oBEuKq2pRqVNH8oaTcuRaYht2Hw1RN1K0p8"
access_token <- "130998524-eAfLn559CcPIG1PeSyJk4LJvuvjbyKU9KgFeC8Xm"
access_token_secret <- "9FfCiqVGMywEPD92xa3Bl3ssZoX5fNDqyg2Ymxvh37Zds"
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

list_of_tweets <- searchTwitter("kramer") %>%
  map(~ .x$text) %>%
  paste() %>%
  str_split(" ") 
freq_table <- do.call("rbind", list_of_tweets) %>%
  as_data_frame() %>%
  gather(source, word) %>%
  count(word)

wordcloud(freq_table$word, freq_table$n)

wordcloud2(freq_table)
