#!/bin/bash

# Written by Mark Thompson (Agile Technology Solutions)
# for ELM Modern Copy administration

#DB_SERVER=localhost
ELM_DB_USER=elm_debug_user
ELM_DB_NAME=elm_release
CONFIG_TABLE=ELM_CONFIG
CONTACT_KEY=CONTACT_EMAIL

if [[ $# -ne 1 ]]; then
  USAGE_ERROR=TRUE
else
  USAGE_ERROR=FALSE
  EMAIL=$1
fi

if [[ ${USAGE_ERROR} = "TRUE" ]]; then
  echo "USAGE ERROR: $0 <contact_email_address>"
  echo
  exit 1
fi

echo
echo This command updates the configuration for the
echo CONTACT email address in the local elm_release database.
echo
echo Email contact will be set to ${EMAIL}
echo

echo You will be prompted to enter the elm_debug_user password...

# Read Password
echo -n Password:
read -s PASSWORD
#echo
#echo Password supplied: $PASSWORD

set_contact() {
  #cat <<-endsql
  mysql --user=${ELM_DB_USER} --password=${PASSWORD} <<-endsql

  use ${ELM_DB_NAME};

  /*
  SELECT * FROM ${CONFIG_TABLE} WHERE CODE = '${CONTACT_KEY}';
  */

  DELETE FROM ${CONFIG_TABLE} WHERE CODE = '${CONTACT_KEY}';

  INSERT INTO ${CONFIG_TABLE} (code, val)
    VALUES ('${CONTACT_KEY}', '${EMAIL}');

  /*
  SELECT * FROM ${CONFIG_TABLE} WHERE CODE = '${CONTACT_KEY}';
  */
endsql
}

set_contact

echo
