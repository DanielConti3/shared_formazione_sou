#!/bin/bash
source Funzioni.sh


activity=()

i=1

read -p "Vuoi aggiungere un'attività? (Y/N) " answer


while [[ "$answer" =~ [YyNn] ]]; do

  if [[ "$answer" =~ [Yy] ]]; then

     read -p "Cosa vuoi aggiungere? " newelement

     activity+=("$newelement")

     echo "${activity[@]}"

     read -p "vuoi aggiungerne un'altro? (Y/N) " answer

   else

    echo "addio"
    break 
  fi
done

random_selector
 


