#!/bin/bash
scriptpath=$(realpath $0)
dirpath=$(dirname $scriptpath)                        

source $dirpath/lib/functions.sh

login

create_list

random_selector
