# Connect to local example mongo db
# https://docs.mongodb.com/getting-started/shell/import-data/
# sudo service mongod start
# mongoimport --db test --collection restaurants --drop --file ./primer-dataset.json
library(mongolite)
con <- mongo("restaurants", url = "mongodb://localhost/test")
restaurant <- con$find('{"restaurant_id": "30075445"}')

pipeline <- '[
{
  "$project" : 
  {
  "latitude"  : {
  "$arrayElemAt" : [ "$address.coord", 1 ]
  },
  "longitude" : {
  "$arrayElemAt" : [ "$address.coord", 0 ]
  },
  "date" : {
  "$arrayElemAt" : [ "$grades.date", 0 ]
  },
  "grade" : {
  "$arrayElemAt" : [ "$grades.date", 1 ]
  },
  "score" : {
  "$arrayElemAt" : [ "$grades.date", 2 ]
  }
  }
}
]'

unwind_restaurants <- con$aggregate(pipeline)
