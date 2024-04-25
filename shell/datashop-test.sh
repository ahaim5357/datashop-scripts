#!/usr/bin/env bash

# TODO: Check .env in project, Check ~/.datashop/credentials, Check $DATASHOP_ACCESS_KEY_ID; $DATASHOP_SECRET_ACCESS_KEY
# Read in environment variables

# Currently grabbing keys from .env file
export $(grep -v '^#' .env | xargs -d '\n')

# TODO: Expand outside of GET request
method="GET"
contentMD5=""
contentType=""
timestamp=`TZ=GMT date "+%a, %d %b %Y %H:%M:%S %Z"`
uripath="/datasets/1"
# Base64#encodeBase64 when isChunked is true, adds carriage return (\r\n) after every 76 bytes
# TODO: Remove jq requirement
apisig=`printf "%s\n%s\n%s\n%s\n%s" "${method}" "${contentMD5}" "${contentType}" "${timestamp}" "${uripath}" | openssl dgst -binary -sha1 -hmac "${DATASHOP_SECRET_ACCESS_KEY}" | base64 | sed 's/.\{76\}/&\r/g'`
apisig=`printf "${apisig}\r\n" | jq --slurp --raw-input --raw-output @uri`

curl --tlsv1 --tls-max 1.2 -X $method -H "authorization: DATASHOP ${DATASHOP_ACCESS_KEY_ID}:${apisig}" -H "date: ${timestamp}" -H "accept: text/xml" -H "user-agent: TestService/1.0.0" -H "connection: keep-alive" "https://pslcdatashop.web.cmu.edu/services${uripath}"

# Unset environment variables once finished
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
