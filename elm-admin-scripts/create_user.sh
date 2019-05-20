#!/bin/bash

# Written by Mark Thompson (Agile Technology Solutions)
# for ELM Modern Copy administration

URL="https://localhost/database/login/create-user.php"

if [[ $# -ne 2 ]]; then
  echo "USAGE ERROR: $0 <email> <password>"
  exit 1
else
  USER_EMAIL=$1
  USER_PASS=$2
fi

create_user () {
  local USER_EMAIL=$1
  local USER_PASS=$2

  echo "User e-mail is ${USER_EMAIL}"
  #echo "User password is ${USER_PASS}"

  #curl -i -k --data "email=mark.thompson@ku.edu&pass=BadPass1" -X POST "${URL}"
  #curl -i -k --data '{"email":"mark.thompson@ku.edu","pass":"BadPass1"}' -X POST -H "Content-Type: application/json" "${URL}"

  #DATA="'"'{"email":"'${USER_EMAIL}'", "pass":"'${USER_PASS}'"}'"'"
  #CONTENT_TYPE="Content-Type: application/json" "${URL}"

  DATA="email=${USER_EMAIL}&pass=${USER_PASS}"
  CONTENT_TYPE="Content-Type: application/x-www-form-urlencoded"

  #echo curl -i -k --data "${DATA}" -X POST -H "${CONTENT_TYPE}" "${URL}"
  curl -i -k --data "${DATA}" -X POST -H "${CONTENT_TYPE}" "${URL}"
}

create_user "${USER_EMAIL}" "${USER_PASS}"
