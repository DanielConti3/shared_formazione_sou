#!/bin/bash
#
#Function initializing, give a random option among the elements of the array
source funzioni.sh


arraydir=/Users/$USER/Desktop/array
arraytxt=/Users/$USER/Desktop/array/array.txt

[ -d $arraydir ] || mkdir $arraydir
[ -f $arraytxt ] || touch $arraytxt

#Declare array
activity=($(<"$arraytxt")) 

#Start loop to fill the array
read -p "Vuoi aggiungere un'attività? (Y/N) " answer

while [[ "$answer" =~ [YyNn] ]]; do

  if [[ "$answer" =~ [Yy] ]]; then

    read -p "Cosa vuoi aggiungere? " newelement
    echo $newelement >> $arraytxt
    activity+=("$newelement")
    read -p "Vuoi aggiungerne un'altro? (Y/N) " answer

#Break loop
  elif [[ "$answer" =~ [Nn] ]]; then

    echo -e "La tua lista è: "${activity[@]}"\n"
    break

  fi
done

#Start Function
random_selector
 


