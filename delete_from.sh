#!/usr/bin/bash

declare -A name_order
declare -a col_names

function make_colName_colID_dictionary(){

    num_of_columns=$(wc -l "$table_name metadata" | cut -c1)

    IFS=$'\n' read -d '' -r -a lines < "$table_name metadata"
        
        for i in "${!lines[@]}"
        do
            IFS=':' read -r -a column <<< "${lines[i]}"
            col_names[$i]=${column[0]}
        done

        for ((i=0; i<num_of_columns; i++))
        do
            name_order[${col_names[$i]}]=$(($i+2))
        done
}


function delete_from_table(){
    make_colName_colID_dictionary

    echo "Choose deletion method: " 

    select choice in "for all" "for specific record" 
    do
        case $choice in
         "for all" )
         delete_all
         ;;
         "for specific record" )
         delete_record
         ;;
         * )
            echo "Invalid answer please"  
        esac 

    done
}

function delete_all(){
    > $table_name
    echo "the table contents are deleted successfully"
}

function delete_record(){

    echo "********* WHERE Clause ************"
    read -p "Enter the column of where clause: " colName_where
    read -p "Enter the $colName_where value of the where cluase: " colVal_where

     if  [[ $colName_where == +([a-zA-Z0-9_-])  &&  $colName_where == [a-zA-Z]* ]] ;then

        colName_where_isFound=$(grep $colName_where "$table_name metadata")

        if [[ $colName_where_isFound ]] ;then

            col_where_index=${name_order[$colName_where]}

            val_where=$colVal_where

            # echo $col_where_index
            # echo $col_set_index
            # echo $val_where
            # echo $val_set

            # $"'$col_index'"="'$new_value'"
            # print $0
            awk -F : -v OFS=: '
            {
                if($"'$col_where_index'" != "'$val_where'")
                {   
                        print $0
                }
                
            } ' $table_name > tmp && mv tmp `pwd`/$table_name

        else
            echo "No column with such name"
        fi 
    else
        echo "Error: vioaltes the naming convension"
    fi
}




function main(){
    
    while true
        do
        read -p "Enter table name to delete from: " table_name 
        if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
            if [ -e $table_name ] ; then 
                
                echo "correct name and the table exists"
                delete_from_table
                break
            
            else 
                echo "Sorry this table's not existed "
                break
            fi

        else
                echo " Error in the table name "
        fi
    done
}
main