#!/bin/bash
# Tavily Search Tool for AI News Collection

API_KEY="${TAVILY_API_KEY:-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}"
QUERY="${1:-AI artificial intelligence latest news}"
MAX_RESULTS="${2:-10}"

curl -s -X POST https://api.tavily.com/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"query\": \"$QUERY\",
    \"search_depth\": \"advanced\",
    \"include_answer\": true,
    \"max_results\": $MAX_RESULTS,
    \"time_range\": \"day\"
  }"
