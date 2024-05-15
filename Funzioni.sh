#!/bin/bash

#this script is intended to randomly select an element in the array and propose it to the user
#the scrip is a function, if you want to use it by himself comment line 5 and 66, and uncomment line 8 

function random_selector {

#declare variables
#activity=("D&D 5e" "D&D Pathfinder" "Monopoly" "Cluedo" "Poker" "Briscola" "Scopa")
array_length=${#activity[@]}
index=$(($RANDOM % $array_length))

#inizialize question loop
while [[ $array_length -gt 0 ]]; do
  
  echo -e "\nTi va di giocare a ${activity[$index]}?\n"
  read -p 'Inserisci "Y" per giocare o "N" per saltare: ' answer

#answer "si"  
  if [[ "$answer" =~ [Yy] ]]; then

    echo "Ottimo! Iniziamo a giocare a ${activity[$index]}."
    break

#answer "no"
  elif [[ "$answer" =~ [Nn] ]]; then
     
#Inizialize and build new_array without previusly suggested elemts
    new_activity=()
    j=0

      for ((j=0; j<${array_length}; j++)); do

        if [[ $j -ne $index ]]; then

          new_activity+=("${activity[$j]}")

        fi
      done
  
    activity=("${new_activity[@]}")

    array_length=${#activity[@]}

#If all elemnts have alredy been suggested and new_array is empty close progra, if not suggest new onem    
    if [[ $array_length -eq 0 ]]; then

      echo "Mi dispiace, non ho più giochi da proporre!"
      break

    else 

      echo "Ok, proviamo un altro gioco."
      index=$(($RANDOM % $array_length))     
    
    fi

#If answer is not "si" or "no" ask again for same element of the array
  else 

    echo "Risposta non valida, riprova"

  fi

done
}
