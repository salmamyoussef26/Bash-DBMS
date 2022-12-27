#!/usr/bin/bash

#**********no repeated columns*********


echo "Create table: "

function main(){

    while true
    do
        read -p "Enter the table name: " table_name
    if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
            if [ -e $table_name ]; then
                echo "This table is already existed."
            else
                echo "Correct name & the file was created."
                touch ./$table_name
                touch ./"$table_name metadata"
                table_creation
                break
            fi
        else
            echo "Error in naming the table please, try again. "
            
    fi 
    done
}
#-------------------------


function table_creation(){
    declare -i num_of_columns

    read -p "Enter the number of columns: " num_of_columns

    declare -a columns
    echo "columns information: (name, datatype) respectively: "
    for ((i=0; i<num_of_columns; i++))
    do
        for ((j=0; j<2; j++))
        do
            read -p "column # $(($i+1)): " columns[$i,$j]
            if [[ ${columns[$i,$j]} == "id" ]]; then
                echo "id is not allowed, it's auto incremented."
                break
            else
                echo -n ${columns[$i,$j]}":" >> ./"$table_name metadata"
            fi
        done
        
        echo -n -e "\n"  >> ./"$table_name metadata"
    done
}

main