#!/bin/bash
scriptpath=$(realpath $0)
dirpath=$(dirname $scriptpath)                        

source $dirpath/lib/functions.sh

login

while true; do
  echo -e "\nEnter one of the following options\n E) Edit your library;\n R) Select randomly a game from your library;\n B) Do both;\n Q) Quit"   
  read -p ": " menu 
  echo

  case $menu in
    [Ee])
      create_list
      quit
      ;;

    [Rr])
      random_selector
      quit
      ;;

    [Bb])
      create_list
      random_selctor
      quit
      ;;

    [Qq])
      echo "Good bye"
      exit
      ;;
  esac
done
