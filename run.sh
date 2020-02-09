#!/bin/bash

source api.properties

INPUT=$1
OUTPUT=$2

curl -c cookies.txt --data "skin=${SKIN}&username=${SAUSERNAME}&password=${SAPASSWORD}" https://${OUCAMPUS}/authentication/admin_login > /dev/null

curl -b cookies.txt --data "skin=${SKIN}&account=${INPUT}&username=${ADMIN}" https://${OUCAMPUS}/authentication/login > /dev/null
curl -b cookies.txt https://${OUCAMPUS}/users/list | ./jq-linux64 -r '.[] | "\(.username) \(.privilege) \"\(.first_name)\" \"\(.last_name)\" \(.approver)"' | xargs -l1 ./create-user.sh $OUTPUT

curl -b cookies.txt --data "skin=${SKIN}&account=${INPUT}&username=${ADMIN}" https://${OUCAMPUS}/authentication/login > /dev/null
curl -b cookies.txt https://${OUCAMPUS}/users/list | ./jq-linux64 -r '.[] | "\(.username) \(.privilege) \"\(.first_name)\" \"\(.last_name)\""' | xargs -l1 ./create-user.sh $OUTPUT
