#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --typles-only -c"

if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
  else
    #default parameters
    ELEMENT_FOUND=0

    RESULT_ELEMENT_NUMBER=0
    RESULT_ELEMENT_NAME_FULL='Default'
    RESULT_ELEMENT_NAME_SHORT='Df'
    RESULT_ELEMENT_TYPE_ID=0
    RESULT_ELEMENT_TYPE='default'
    RESULT_ELEMENT_MASS=1.000
    RESULT_ELEMENT_MELTING_POINT=0
    RESULT_ELEMENT_BOILINT_POINT=0

    #check if $1 = digit else, get ID
    #check is $1 = 2 letters (Li), get ID else
    #check if $1 = Word (Lithium), get ID

    #if element found
    if [[ $ELEMENT_FOUND != 0 ]]
    then
      #update element details

      #show element details
      echo "The element with atomic number $RESULT_ELEMENT_NUMBER is $RESULT_ELEMENT_NAME_FULL ($RESULT_ELEMENT_NAME_SHORT). It's a $RESULT_ELEMENT_TYPE, with a mass of $RESULT_ELEMENT_MASS amu. $RESULT_ELEMENT_NAME_FULL has a melting point of $RESULT_ELEMENT_MELTING_POINT celsius and a boiling point of $RESULT_ELEMENT_BOILINT_POINT celsius."
    else
      echo "I could not find that element in the database."
    fi
fi