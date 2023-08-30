#!/usr/bin/env bash

#### VARIABLES #######
# CodeLogic user name.
USERNAME='YOUR_USERNAME_HERE'
#CodeLogic password.
PASSWORD='YOUR_PASSWORD_HERE'
# URL encode the USERNAME.
USERENCODED=`printf %s "$USERNAME" | jq -s -R -r @uri`
# URL encode the PASSWORD.
PASSENCODED=`printf %s "$PASSWORD" | jq -s -R -r @uri`
# The url/ip address of your CodeLogic instance.  Example: http://192.168.0.74, or https://codelogichost.com.
CODELOGICURL='YOUR_CODELOGIC_HOST'

# Get Bearer token.
TOKEN=`curl -v -X POST "${CODELOGICURL}/codelogic/server/authenticate" -H "accept: application/json" -H "Content-Type: application/x-www-form-urlencoded" -d "password=${PASSENCODED}&username=${USERENCODED}" | jq -r '.access_token'`

# Get all endpoints, and output to CSV.
ENDPOINTCSV=`curl -s -X GET "${CODELOGICURL}/codelogic/server/tabular/nodes/csv?itemTypes=Endpoint" -H "accept: text/csv" -H "Authorization: Bearer ${TOKEN}" --output endpoint.csv`
