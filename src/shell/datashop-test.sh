#!/usr/bin/env bash

DATASHOP_ACCESS_KEY_ID=""
DATASHOP_SECRET_ACCESS_KEY=""
# URL="https://pslcdatashop.web.cmu.edu"
URL="https://pslc-qa.andrew.cmu.edu/datashop"

# QA URL: https://pslc-qa.andrew.cmu.edu/datashop/

# TODO: Check .env in project, Check ~/.datashop/credentials, Check $DATASHOP_ACCESS_KEY_ID; $DATASHOP_SECRET_ACCESS_KEY
# Read in environment variables

# Currently grabbing keys from .env file
export $(grep -v '^#' .env | xargs -d '\n')

# TODO: Expand outside of GET request
method="GET"
contentMD5=""
contentType=""
timestamp=`TZ=GMT date "+%a, %d %b %Y %H:%M:%S %Z"`
# uripath="/datasets/1"
uripath="/datasets/1142"
# Base64#encodeBase64 when isChunked is true, adds carriage return (\r\n) after every 76 bytes
# TODO: Remove jq requirement
apisig=`printf "%s\n%s\n%s\n%s\n%s" "${method}" "${contentMD5}" "${contentType}" "${timestamp}" "${uripath}" | openssl dgst -binary -sha1 -hmac "${DATASHOP_SECRET_ACCESS_KEY}" | base64 | sed 's/.\{76\}/&\r/g'`
apisig=`printf "${apisig}\r\n" | jq --slurp --raw-input --raw-output @uri`

curl --tlsv1 --tls-max 1.2 -X $method \
    -H "authorization: DATASHOP ${DATASHOP_ACCESS_KEY_ID}:${apisig}" \
    -H "date: ${timestamp}" -H "accept: text/xml" -H "user-agent: TestService/1.0.0" \
    -H "connection: keep-alive" "${URL}/services${uripath}"

echo "-----------------------------------"

# Make sure all `"` are escaped assied from the two
# TODO: Validate test by setting PI to actual name
data="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<pslc_datashop_message>
<project>
<name>Dummy Test!</name>
<description>Test of the system.</description>
<tags>#Science #Learning</tags>
<pi>bleber</pi>
<data_provider>bleber</data_provider>
<data_collection_type>not_specified</data_collection_type>
<shareable_status>not_submitted</shareable_status>
<subject_to_ds_irb>yes</subject_to_ds_irb>
<research_mgr_notes>IGNORE THIS</research_mgr_notes>
<needs_attention>yes</needs_attention>
<discourse_dataset>no</discourse_dataset>
</project>
</pslc_datashop_message>"
method="POST"
# I don't even think contentMD5 and contentType are used based on Java example code
contentMD5=""
contentType=""
timestamp=`TZ=GMT date "+%a, %d %b %Y %H:%M:%S %Z"`
uripath="/datasets/projects/add"
# Base64#encodeBase64 when isChunked is true, adds carriage return (\r\n) after every 76 bytes
# TODO: Remove jq requirement
apisig=`printf "%s\n%s\n%s\n%s\n%s" "${method}" "${contentMD5}" "${contentType}" "${timestamp}" "${uripath}" | openssl dgst -binary -sha1 -hmac "${DATASHOP_SECRET_ACCESS_KEY}" | base64 | sed 's/.\{76\}/&\r/g'`
apisig=`printf "${apisig}\r\n" | jq --slurp --raw-input --raw-output @uri`

# URL Encode data
data=`printf "${data}" | jq --slurp --raw-input --raw-output @uri`

curl -v --tlsv1 --tls-max 1.2 -X $method \
    -H "authorization: DATASHOP ${DATASHOP_ACCESS_KEY_ID}:${apisig}" \
    -H "date: ${timestamp}" -H "accept: text/xml" -H "accept-charset: UTF-8"\
    -H "user-agent: TestService/1.0.0" -H "connection: keep-alive" \
    -H "content-type: application/x-www-form-urlencoded;charset=UTF-8" -d "postData=${data}" "${URL}/services${uripath}"


# Unset environment variables once finished
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
