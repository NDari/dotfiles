#!/usr/bin/env bash

LOGGROUPNAME=${1:-"lskdjflskdjf-staging-green"}
QUERY=${2:-"fields message"}
QUERY="$QUERY | limit 10000"

QI=$(aws logs start-query \
  --log-group-name $LOGGROUPNAME  \
  --start-time $(date --date '-30 min' "+%s") \
  --end-time $(date "+%s") \
  --query-string "$QUERY" \
  | jq -r ".queryId")

  # --query-string "fields message | filter message like /Starting/ | limit 20" \

sleep 10 # wait for the query to run

aws logs get-query-results --query-id $QI | jq -r ' .results | .[] | .[] | select(.field == "message") | .value | gsub("[\\n]"; "")'
