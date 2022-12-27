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

function select_table(){
    make_colName_colID_dictionary

    echo "Choose selection method: 
        [a] for all
        [s] for selection
        [p] for projection " 

    select choice in "a" "s" "p"
    do
        case $choice in
         "a" )
         select_all
         ;;
         "s" )
         selection
         ;;

         "p" )
         projection
         ;;
         * )
            echo "Invalid answer please, enter [a/s/p]"  
        esac 

    done
}



function select_all(){

    cat $table_name
}

function selection(){

    #read -p "all or specific columns: " choice

    select choice in "all" "specific columns"
    do
        case $choice in
            "all" )
            selection_all
            ;;
            "specific columns" )
            selection_specific_columns
            ;;

            * )
                echo "invalid choice"
        esac

    done

}

function selection_all(){

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
                if($"'$col_where_index'" == "'$val_where'")
                {
                        print $0
                }
            } ' $table_name 

        else
            echo "No column with such name"
        fi 
    else
        echo "Error: vioaltes the naming convension"
    fi
}

function selection_specific_columns(){

    read -p "Enter the specific column: " specific_col
    echo "********* WHERE Clause ************"
    read -p "Enter the column of where clause: " colName_where
    read -p "Enter the $colName_where value of the where cluase: " colVal_where

     if  [[ $colName_where == +([a-zA-Z0-9_-])  &&  $colName_where == [a-zA-Z]* 
      &&  $specific_col == +([a-zA-Z0-9_-])  &&  $specific_col == [a-zA-Z]* ]] ;then

        colName_where_isFound=$(grep $colName_where "$table_name metadata")
        specific_col_isFound=$(grep $specific_col "$table_name metadata")

        if [[ $colName_where_isFound && $specific_col_isFound ]] ;then

            col_where_index=${name_order[$colName_where]}

            specific_col_index=${name_order[$specific_col]}

            val_where=$colVal_where

            # echo $col_where_index
            # echo $col_set_index
            # echo $val_where
            # echo $val_set

            # $"'$col_index'"="'$new_value'"
            # print $0
            #echo $specific_col_index

            awk -F : -v OFS=: '
            {
                    if($"'$col_where_index'" == "'$val_where'")
                    {
                         print $"'$specific_col_index'"
                    }
            } ' $table_name 

        else
            echo "No column with such name"
        fi 
    else
        echo "Error: vioaltes the naming convension"
    fi

}

function projection(){
 
    read -p "Enter the column to be displayes: " column_name

     if  [[ $column_name == +([a-zA-Z0-9_-])  &&  $column_name == [a-zA-Z]* ]] ;then

        column_name_isFound=$(grep $column_name "$table_name metadata")

        if [[ $column_name_isFound ]] ;then

            column_name_index=${name_order[$column_name]}

            # echo $col_where_index
            # echo $col_set_index
            # echo $val_where
            # echo $val_set

            # $"'$col_index'"="'$new_value'"
            # print $0
            awk -F : -v OFS=: '
            {
                print $"'$column_name_index'"
            } ' $table_name 

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
        read -p "Enter table name to select from: " table_name 
        if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
            if [ -e $table_name ] ; then 
                
                echo "correct name and the table exists"
                select_table
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