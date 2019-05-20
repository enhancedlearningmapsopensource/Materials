#!/bin/bash

# Written by Mark Thompson (Agile Technology Solutions)
# for ELM Modern Copy administration

#DB_SERVER=localhost
ELM_DB_USER=elm_debug_user
ELM_DB_NAME=elm_release
CONFIG_TABLE=ELM_CONFIG

echo
echo "This command displays the ELM configuration”
echo “in the local ${ELM_DB_NAME} database."
echo
echo "You will be prompted to enter the ${ELM_DB_USER} password..."
echo

# Read Password
echo -n Password:
read -s PASSWORD
echo
#echo Password supplied: $PASSWORD

show_config_item() {
  local DESC=$1
  local KEY=$2

  VAL=$(echo "SELECT VAL FROM ${ELM_DB_NAME}.${CONFIG_TABLE} " \
             "WHERE CODE = '${KEY}' ORDER BY CODE;" \
           | mysql --user=${ELM_DB_USER} --password=${PASSWORD} | grep -v VAL )
  
  echo "${DESC} ${VAL}"
}

echo

show_config_item 'Locater Tool URL: ' LOCATER_TOOL_PATH
show_config_item 'Mail Enabled: '     SELF_CREATION_ON
show_config_item 'Contact Email: '    CONTACT_EMAIL

echo
