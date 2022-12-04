#/bin/bash

# https://serpapi.com/playground?engine=google_trends&q=Klima&geo=CH&data_type=TIMESERIES&tz=60


 rm klima_all.sql
 for i in {2022..2022}
 do
  echo "insert into google_trends values (2099, '" >> klima.sql
  curl --get https://serpapi.com/search \
   -d device="desktop" \
   -d engine="google_trends" \
   -d tz="60" \
   -d q="Klima" \
   -d geo="CH" \
   -d data_type="TIMESERIES" \
   -d date="2004-01-01+2022-12-31" \
   -d api_key="3ec8c7276a856b2e5c355e66b796953eee133e4583c62fd5b36db6bb5d78ae6e" >> klima_all.sql
   echo "');" >>  klima.sql
   printf "\n" >> klima.sql
done