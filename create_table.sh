#!/usr/bin/bash

#**********no repeated columns*********


echo "Create table"

while true
do
    read -p "enter the table name " table_name
   if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
        if [ -e $table_name ]; then
            echo "this table is already existed"
            continue
        else
            echo "correct name & the file was created"
            touch `pwd`/$table_name
            touch `pwd`/"$table_name metadata"
            break
        fi
    else
        echo "error in naming the table please, try again "
        
   fi 
done
#-------------------------


declare -i num_of_columns
#export -p num_of_columns
read -p "Enter the number of columns" num_of_columns


declare -a columns
echo "columns information: name, datatype, constraint "
for ((i=0; i<num_of_columns; i++))
do
    echo $i
    for ((j=0; j<3; j++))
    do
        read columns[$i,$j]
        echo -n ${columns[$i,$j]} >>`pwd`/"$table_name metadata"
        if [[ $j < 3 ]]; then
            echo -n  ":" >>`pwd`/"$table_name metadata"
        fi
    done
    
    echo -n -e "\n"  >> `pwd`/"$table_name metadata"
done

