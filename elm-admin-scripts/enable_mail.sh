#!/bin/bash

# Written by Mark Thompson (Agile Technology Solutions)
# for ELM Modern Copy administration

#DB_SERVER=localhost
ELM_DB_USER=elm_debug_user
ELM_DB_NAME=elm_release
CONFIG_TABLE=ELM_CONFIG

if [[ $# -ne 1 ]]; then
  USAGE_ERROR=TRUE
elif [[ $1 != "FALSE" && $1 != "TRUE" ]]; then
  USAGE_ERROR=TRUE
else
  USAGE_ERROR=FALSE
  MAIL_ENABLED=$1
fi

if [[ ${USAGE_ERROR} = "TRUE" ]]; then
  echo "USAGE ERROR: $0 <TRUE|FALSE>"
  echo
  echo Need to pass TRUE or FALSE as a parameter depending
  echo on whether or not mail should be enabled.
  echo
  exit 1
fi

echo
echo This command updates the MAIL ENABLED configuration
echo in the local elm_release database.
echo
echo Mail enabled will be set to ${MAIL_ENABLED}
echo

echo You will be prompted to enter the elm_debug_user password...

#cat <<-endsql
mysql -u ${ELM_DB_USER} -p <<-endsql
  use ${ELM_DB_NAME};

  UPDATE ${CONFIG_TABLE}
    SET VAL = '${MAIL_ENABLED}'
    WHERE CODE = 'SELF_CREATION_ON';
endsql

echo

