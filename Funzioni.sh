#!/bin/bash

#This script is a compendium of functions

#This script is intended to randomly select an element in the array and propose it to the user
function random_selector {

#Declare variables
array_length=${#activity[@]}
index=$(($RANDOM % $array_length))

#Inizialize question loop
while [[ $array_length -gt 0 ]]; do
  
  echo -e "\nWould you like to play at? ${activity[$index]}?\n"
  read -p '"Y" to confirm or "N" to try a new one ' answer

#Answer "si"  
  if [[ "$answer" =~ [Yy] ]]; then

    echo "Nice! Lets play at ${activity[$index]}."
    break

#Answer "no"
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

      echo -e "\nSorry, no other game are aviable in your list!\n"
      break

    else 

      echo "Ok, lets try with another one!"
      index=$(($RANDOM % $array_length))     
    
    fi

#If answer is not "si" or "no" ask again for same element of the array
  else 

    echo "Wrong imput, use only (Y/N)."

  fi

done
}

#This function creates a txt file based on the username variable whitch is then use to compile an array
function create_list {

#Declare path var and check for file and dir existance
arraydir=/Users/$USER/Desktop/array
arraytxt=/Users/$USER/Desktop/array/$username.txt

[ -d $arraydir ] || mkdir $arraydir
[ -f $arraytxt ] || touch $arraytxt

#Declare array
activity=($(<"$arraytxt")) 

#Start loop to fill the array
read -p "Would you like to add an activity? (Y/N) " answer

while [[ "$answer" != [YyNn] ]]; do

  echo -e "\nWrong input, please try again only with (Y/N). "
  read answer

done

while [[ "$answer" =~ [YyNn] ]]; do

  if [[ "$answer" =~ [Yy] ]]; then

    read -p "What would you want to add? " newelement
    echo $newelement >> $arraytxt
    activity+=("$newelement")
    read -p "Would you like to add something else? (Y/N) " answer

    while [[ "$answer" != [YyNn] ]]; do

      echo -e "\nWrong input, please try again only with (Y/N). "
      read answer

    done


#Check intentions to remove element
  elif [[ "$answer" =~ [Nn] ]]; then
    
    read -p "would you like to remove an activity from the list? (Y/N) " remove 
    
    while [[ "$remove" != [YyNn] ]]; do

      echo -e "\nWrong input, please try again only with (Y/N). "
      read remove

    done

#Start loop to remove elemnt
    while [[ "$remove" =~ [Yy] ]]; do 
    
      echo -e "\nLa tua lista è: "${activity[@]}"\n"
      read -p "Which activity would you like to remove? " removed
      
      sed -i -e "s/"$removed"$//g" "$arraytxt"
      activity=($(<"$arraytxt")) 

      read -p "would you like to remove another activity from the list? (Y/N) " remove 
      
      while [[ "$remove" != [YyNn] ]]; do

        echo -e "\nWrong input, please try again only with (Y/N). "
        read remove

      done
    
    done

  fi
done

}
