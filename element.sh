#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --typles-only -c"

if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
  else
    #default parameters
    ELEMENT_FOUND=0

    ELEMENT_NUMBER=0
    #check if $1 = digit else
    #check is $1 = 2 letters (Li) else
    #check if $1 = Word (Lithium)

    #if element found
    if [[ $ELEMENT_FOUND != 0 ]]
    then
      echo Element found
      #show element details
    else
      echo "I could not find that element in the database."
    fi
fi