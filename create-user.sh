#!/bin/bash

source api.properties

echo running $*

account=$1
username=$2
privilege=$3
if [ "$privilege" = "10" ]
then
	privilege=9
fi
first_name=`echo $4`
last_name=$5
approver=$6

curl -sc cookies.txt --data "skin=${SKIN}&username=${SAUSERNAME}&password=${SAPASSWORD}" https://${OUCAMPUS}/authentication/admin_login > /dev/null
curl -sb cookies.txt --data "skin=${SKIN}&account=${account}&username=${ADMIN}" https://${OUCAMPUS}/authentication/login > /dev/null
curl -b cookies.txt --data "username=${username}&email=${username}&password=&privilege=${privilege}&first_name=$first_name&last_name=$last_name&approver=$approver" https://${OUCAMPUS}/users/new

