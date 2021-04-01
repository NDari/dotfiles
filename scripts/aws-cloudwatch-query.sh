#!/usr/bin/env bash

SLEEPTIME=${1:-5}
LOGGROUPNAME=${2:-"onlineapp-staging-green"}

QI=$(aws logs start-query \
  --log-group-name $LOGGROUPNAME  \
  --start-time $(date --date '-30 min' "+%s") \
  --end-time $(date "+%s") \
  --query-string "fields message" \
  | jq -r ".queryId")

  # --query-string "fields message | filter message like /Starting/ | limit 20" \

sleep $SLEEPTIME # wait for the query to run

aws logs get-query-results --query-id $QI | jq -r ' .results | .[] | .[] | select(.field == "message") | .value | gsub("[\\n]"; "")'
