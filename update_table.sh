#!/usr/bin/bash
declare -A name_order
declare -a col_names

function update_table(){

    make_colName_colID_dictionary  
     
    echo "Do you want to enter a condition to change specific record? 
    [y/n] NOTE: no condition means the column value in all the records will be updated " 

    select choice in "y" "n"
    do
        case $choice in
         "y" )
         #code of where cond
         where_condition
         ;;
         "n" )
         #code of column
         no_where_condition
         ;;
         * )
            echo "Invalid answer please, enter [y/n]"  
        esac 

    done

    # read -p "Enter the column name to be updated: " column_name

    # if [[ $column_name == +([a-zA-Z0-9_-]) ]] && [[ $column_name == [a-zA-Z]* ]];then

    #     column_isFound=$(grep $column_name "$table_name metadata")

    #     if [[ $column_isFound ]];then

    #         read -p "The new value for the column $column_name: " new_column_value

    #         col_index=${name_order[$column_name]}
    #         new_value=$new_column_value 

    #         if [[ $answer  == "n" ]]; then
    #             awk -F : -v OFS=: '
    #             {
    #               $"'$col_index'"="'$new_value'"
    #               print $0
    #             } ' $table_name > tmp && mv tmp `pwd`/$table_name
    #         elif [[ $answer == "y" ]]
    #             #code of specific record 
    #             echo "hhhh"
    #         else 
    #             echo "Invalid answer please, enter [y/n]"
    #         fi 

    #     else
    #         echo "No column with such name"
    #     fi
    # else
    #     echo "ERROR: violates the naming convention"

    # fi  

    #-------------- 
    #كان شغااااااااااااااااااااال
    # if [[ $answer  == "n" ]]; then
        
    #     if [[ $column_name == +([a-zA-Z0-9_-]) ]] && [[ $column_name == [a-zA-Z]* ]];then

    #             column_isFound=$(grep $column_name "$table_name metadata")

    #             if [[ $column_isFound ]];then

    #             read -p "the new value for the column: " new_column_value
    #             col_index=${name_order[$column_name]}
    #             new_value=$new_column_value 

    #             awk -F : -v OFS=: '
    #             {
    #               $"'$col_index'"="'$new_value'"
    #               print $0
    #             } ' $table_name > tmp && mv tmp `pwd`/$table_name
    #             else
    #                 echo "No column with such name"
    #             fi
    #     else
    #         echo "ERROR: in the table name"
    #     fi
    # else 
    #      echo "hhh"
    # fi
}

function no_where_condition(){

    read -p "Enter the column name to be updated: " column_name
    
    if [[ $column_name == +([a-zA-Z0-9_-]) ]] && [[ $column_name == [a-zA-Z]* ]];then

        column_isFound=$(grep $column_name "$table_name metadata")

        if [[ $column_isFound ]];then

            read -p "Enter the new value for the column $column_name: " new_column_value

            col_index=${name_order[$column_name]}
            new_value=$new_column_value 

            awk -F : -v OFS=: '
            {
                $"'$col_index'"="'$new_value'"
                print $0
            } ' $table_name > tmp && mv tmp `pwd`/$table_name

        else
            echo "No column with such name"
        fi 
    else
        echo "Error: vioaltes the naming convension"
    fi
}

function where_condition(){

    # UPDATE Customers
    # SET ContactName = 'Alfred Schmidt', City = 'Frankfurt'
    # WHERE CustomerID = 1;
    echo "********* WHERE Clause ************"
    read -p "Enter the column of where clause: " colName_where
    read -p "Enter the $colName_where value of the where cluase: " colVal_where
    
    echo "******* SET Clause************"
    read -p "Enter column to be updated: " colName_set
    read -p "Enter $colName_set value to be updated: " colVal_set

    if  [[ $colName_where == +([a-zA-Z0-9_-])  &&  $colName_where == [a-zA-Z]* 
    &&   $colName_set == +([a-zA-Z0-9_-])  &&  $colName_set == [a-zA-Z]* ]] ;then

        colName_where_isFound=$(grep $colName_where "$table_name metadata")
        colName_set_isFound=$(grep $colName_set "$table_name metadata")

        if [[ $colName_where_isFound ]] && [[ $colName_set_isFound ]];then

            col_where_index=${name_order[$colName_where]}
            col_set_index=${name_order[$colName_set]}

            val_where=$colVal_where
            val_set=$colVal_set

            # echo $col_where_index
            # echo $col_set_index
            # echo $val_where
            # echo $val_set

            # $"'$col_index'"="'$new_value'"
            # print $0
            awk -F : -v OFS=: '
            {
                for (i=0; i<NF; i++)
                {
                    if($"'$col_where_index'" == "'$val_where'")
                    {
                        $"'$col_set_index'"="'$val_set'"
                    }
                }
                print $0
            } ' $table_name > tmp && mv tmp `pwd`/$table_name

        else
            echo "No column with such name"
        fi 
    else
        echo "Error: vioaltes the naming convension"
    fi
}

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


function main(){

    while true
        do
        read -p "Enter table name to be updated: " table_name 
        if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
            if [ -e $table_name ] ; then 
                
                echo "correct name and the table exists"
                update_table
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