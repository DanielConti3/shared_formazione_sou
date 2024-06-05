#!/bin/bash

#This script is a compendium of functions

#This function is intended to randomly select an element in the array and propose it to the user
function random_selector {

#Declare variables
array_length=${#activity[@]}
while [[ $array_length -eq 0 ]]; do
  echo "Your library is empty, add some game first"
  create_list
  array_length=${#activity[@]}
done
  
index=$(($RANDOM % $array_length))

#Inizialize question loop
while [[ $array_length -gt 0 ]]; do
  echo -e "\nWould you like to play at ${activity[$index]}?\n"
  read -p '"Y" to confirm or "N" to try a new one ' answer

#Answer "si"  
  if [[ "$answer" =~ [Yy] ]]; then
    echo "Nice! Lets play at ${activity[$index]}."
    exit

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
scriptpath=$(readlink -f $0)
dirpath=$(dirname $scriptpath)
arraydir=$dirpath/array
arraytxt=$dirpath/array/$username.txt

[ -d $arraydir ] || mkdir $arraydir
[ -f $arraytxt ] && chmod u=rw,go=r $arraytxt || touch $arraytxt 

old_ifs=$IFS
IFS=$'\n'

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
    read -p "Would you like to remove an activity from the list? (Y/N) " remove 
    
    while [[ "$remove" != [YyNn] ]]; do
      echo -e "\nWrong input, please try again only with (Y/N). "
      read remove
    done
    
#Start loop to remove elemnt
    while [[ "$remove" =~ [Yy] ]]; do 
      sed -i "" "/^[[:space:]]*$/d" $arraytxt
      echo -e "\nYour current list is: "
      cat $arraytxt
      read -p "Which activity would you like to remove? " removed
      sed -i "" "s/"$removed"$//g" "$arraytxt"
      activity=($(<"$arraytxt")) 
      read -p "would you like to remove another activity from the list? (Y/N) " remove 
      
      while [[ "$remove" != [YyNn] ]]; do
        echo -e "\nWrong input, please try again only with (Y/N). "
        read remove
      done
    
    done

#Break from loop
    if [[ "$remove" =~ [Nn] ]]; then
      break
    fi

  fi
done

chmod a-rwx $arraytxt
IFS=$old_ifs

}

#This function allows user to create and login in an account
function login {

#variables
scriptpath=$(readlink -f $0)
dirpath=$(dirname $scriptpath)
logdir=$dirpath/login
credentials=$dirpath/login/credenziali.txt



#check login dir and file existance or create it
[ -d $logdir ] || mkdir $logdir
[ -f $credentials ] && chmod u=rw,go= $credentials || touch $credentials

#ask if user already has account
read -p "Do you have an account?(Y/N)  " confirmation
echo

#create new account if no
if [[ "$confirmation" =~ [Nn] ]]; then
    read -p "username for new account:  " newuser

#if username already exist ask for a new one
    while grep "$newuser"":""*" $credentials>/dev/null
    do
        read -p "Username already taken, try again:  " newuser
    done
    read -p "password for new account:  " -s  newpass
	
#save new username and password in file then ask for a new login
    echo "$newuser"":""$newpass"  >> $credentials
    echo
    read -p "Would you like to login now?(Y/N)  " confirmation
fi

#start login process
if [[ "$confirmation" =~ [Yy] ]]; then
    
  for i in {1..3}; do
    read -p "username: " username
    read -p "password: " -s password

#check credential inside txt file
    if grep "$username"":""$password" $credentials>/dev/null; then
      echo -e "\nWelcome back $username\n"
      break				
	  
    else  
      k=$((3-i))
      echo -e "\nWrong credential, $k attemps remaining"
      if [[ $k -eq 0 ]]; then
        echo -e "\nNo more attempts aviable"
        exit
      fi
    fi

  done

elif [[ "$confirmation" =~ [Nn] ]]; then
  echo "Good bye"
  exit 
else
  echo "Invalid character"
	
fi

chmod a= $credentials

}

function quit {

echo -e "Do you want to quit the program or go back to the menu?\n Q) Quit;\n M) Menu;"
read -p ":" quit
while [[ "$quit" != [QqMm] ]]; do
  echo -e "\nWrong imput, try again\n"
  echo -e "Do you want to quit the pr function [buffer]  the menu?\n Q) Quit;\n M) Menu;"
  read -p ":" quit  

done

if [[ "$quit" =~ [Qq] ]]; then
  exit
  
fi  


}
