#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

IDENTIFIER=$1

# checks for an argument
if [[ -z $IDENTIFIER ]]
then 
  echo "Please provide an element as an argument."
else 
  # outputs information about the element
  if [[ $IDENTIFIER =~ ^[0-9]+$ ]]
  then 
    # if the argument is the atomic number
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$IDENTIFIER")
  
    # checks if the element exists
    if [[ -z $SYMBOL ]]
    then
      # if it does not
      echo "I could not find that element in the database."
    else 
      # if it does
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$IDENTIFIER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$IDENTIFIER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$IDENTIFIER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$IDENTIFIER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$IDENTIFIER")

      echo "The element with atomic number $IDENTIFIER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  elif [[ $IDENTIFIER =~ ^[A-Z]([a-z]?)$ ]]
  then 
    # if the argument is a symbol
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$IDENTIFIER'")

    # checks if the element exists
    if [[ -z $NAME ]]
    then 
      # if it does not
      echo "I could not find that element in the database."
    else 
      # if it does
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$IDENTIFIER'")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($IDENTIFIER). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  elif [[ $IDENTIFIER =~ ^[A-Z][a-z]*$ ]]
  then
    # if the argument is a name
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$IDENTIFIER'")

    # checks if the element exists
    if [[ -z $SYMBOL ]]
    then 
      # if it does not
      echo "I could not find that element in the database."
    else 
      # if it does
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$IDENTIFIER'")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

      echo "The element with atomic number $ATOMIC_NUMBER is $IDENTIFIER ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $IDENTIFIER has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  else
    # for cases where the input is not a symbol or name but starts with a lowercase letter
    echo "I could not find that element in the database."
  fi
fi

