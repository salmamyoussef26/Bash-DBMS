#!/usr/bin/bash

read -p "enter an input " input
if [[ $input == +([a-zA-Z0-9_-]) ]] && [[ $input == [a-zA-Z]* ]];then
    echo "valid"
else
    echo "not valid"
fi
