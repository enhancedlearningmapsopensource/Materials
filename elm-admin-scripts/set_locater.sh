#!/bin/bash

# Written by Mark Thompson (Agile Technology Solutions)
# for ELM Modern Copy administration

#DB_SERVER=localhost
ELM_DB_USER=elm_debug_user
ELM_DB_NAME=elm_release
CONFIG_TABLE=ELM_CONFIG

if [[ $# -ne 1 ]]; then
  USAGE_ERROR=TRUE
else
  USAGE_ERROR=FALSE
  LOCATER_URL=$1
fi

if [[ ${USAGE_ERROR} = "TRUE" ]]; then
  echo "USAGE ERROR: $0 <LOCATER_URL>"
  echo
  echo The Locater Tool URL must be supplied as a parameter.
  echo .e.g. $0 "https://my-locater-server/locatertool/login2"
  echo
  echo To clear the Locater Tool URL, supply an empty string as the parameter.
  echo
  exit 1
fi

echo
echo This command updates the Locater Tool URL
echo configuration in the local "${ELM_DB_NAME}" database.
echo
echo Locater URL will be set to "${LOCATER_URL}"
echo

echo You will be prompted to enter the ${ELM_DB_USER} password...

#cat <<-endsql
mysql -u ${ELM_DB_USER} -p <<-endsql

  use ${ELM_DB_NAME};

  UPDATE ${CONFIG_TABLE}
    SET VAL = '${LOCATER_URL}'
    WHERE CODE = 'LOCATER_TOOL_PATH';
endsql

echo
