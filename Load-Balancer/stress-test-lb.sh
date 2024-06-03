#!/bin/bash

# Variables
URL=$1
REQUESTS=$2
CONCURRENT_REQUESTS=10

# Function to perform a single curl request
perform_request() {
    curl -o /dev/null -s -w "%{http_code}\n" "$URL"
}

# Export the function so it can be used by xargs
export -f perform_request

# Run the requests
seq "$REQUESTS" | xargs -n1 -P"$CONCURRENT_REQUESTS" bash -c 'perform_request'
