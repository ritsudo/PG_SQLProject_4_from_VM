#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

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
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      #try symbol
      SYMBOL_SEARCH_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
      if [[ -z $SYMBOL_SEARCH_RESULT ]]
      then 
        FULL_SEARCH_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
        if [[ -z $FULL_SEARCH_RESULT ]]
        then 
          echo "I could not find that element in the database."
        else
          ELEMENT_FOUND=$FULL_SEARCH_RESULT
        fi
      else
        ELEMENT_FOUND=$SYMBOL_SEARCH_RESULT
      fi
    else
      DIGIT_SEARCH_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
      if [[ -z $DIGIT_SEARCH_RESULT ]]
      then
        echo "I could not find that element in the database."
      else 
        ELEMENT_FOUND=$DIGIT_SEARCH_RESULT
      fi
    fi

    #if element found
    if [[ $ELEMENT_FOUND != 0 ]]
    then
      #update element details
          RESULT_ELEMENT_NUMBER=$(echo $ELEMENT_FOUND | sed 's/ |/"/')
          RESULT_ELEMENT_NAME_FULL=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )
          RESULT_ELEMENT_NAME_SHORT=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )
          RESULT_ELEMENT_TYPE_ID=$(echo $($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )
          RESULT_ELEMENT_TYPE=$(echo $($PSQL "SELECT type FROM types WHERE type_id=$RESULT_ELEMENT_TYPE_ID;") | sed 's/ |/"/' )
          RESULT_ELEMENT_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )
          RESULT_ELEMENT_MELTING_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )
          RESULT_ELEMENT_BOILINT_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_FOUND;") | sed 's/ |/"/' )

      #show element details
      echo "The element with atomic number $RESULT_ELEMENT_NUMBER is $RESULT_ELEMENT_NAME_FULL ($RESULT_ELEMENT_NAME_SHORT). It's a $RESULT_ELEMENT_TYPE, with a mass of $RESULT_ELEMENT_MASS amu. $RESULT_ELEMENT_NAME_FULL has a melting point of $RESULT_ELEMENT_MELTING_POINT celsius and a boiling point of $RESULT_ELEMENT_BOILINT_POINT celsius."
    fi
fi