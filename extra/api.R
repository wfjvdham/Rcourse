library(httr)
library(jsonlite)

url  <- "http://api.epdb.eu"
path <- "eurlex/directory_code"

raw_result <- GET(url = url, path = path)

names(raw_result)

this_raw_content <- rawToChar(raw_result$content)

this_content <- fromJSON(this_raw_content)

this_content_df <- do.call(
  what = "rbind",
  args = map(this_content, as_data_frame)
)
