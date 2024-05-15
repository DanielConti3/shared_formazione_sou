#!/bin/bash
#
#Function initializing, give a random option among the elements of the array
source Funzioni.sh

#Declare array
activity=()

#Start loop to fill the array
read -p "Vuoi aggiungere un'attività? (Y/N) " answer

while [[ "$answer" =~ [YyNn] ]]; do

  if [[ "$answer" =~ [Yy] ]]; then

    read -p "Cosa vuoi aggiungere? " newelement

    activity+=("$newelement")

    echo "${activity[@]}"

    read -p "Vuoi aggiungerne un'altro? (Y/N) " answer

#Break loop
  elif [[ "$answer" =~ [Nn] ]]; then

    echo -e "La tua lista è: ${activity[@]}\n"
    break

  fi
done

#Start Function
random_selector
 


