#!/usr/bin/bash




function auto_incremented_field(){
    echo "the tables columns: "
    head -1 "$table_name metadata" 
    id_user=0

    if [ -s $table_name ]; then
        id_user=$(tail -1 $table_name| cut -d : -f 1)
        ((id_user=$id_user+1))
        echo "$id_user":"" >>$table_name
    else
        id_user=1
        echo "$id_user":"">>$table_name
    fi
}

function insert_records(){
    
    for((i=0; i<num_of_columns-1; i++))
    do
        read -p "enter the column name: " column_name
        isFound=$(grep -Fxq $column_name "$table_name metadata")
        if [[ $column_name == +([a-zA-Z0-9_-]) ]] && [[ $column_name == [a-zA-Z]* ]];then
            if [[ $isFound == 0 ]];then
                read "enter the value for $column_name " column_value
                make_dictionary
                check_column_dataType
                dictionary[${columns_name[$i]}]=${columns_datatype[$i]}
            else
                echo "No column with such name"
            fi
        else
            echo "Sorry, error in the table name"
        fi
    done

    echo "hello insert records"
}

#Make Dictionary
function make_dictionary(){

    : '
    1 arr for keys     -a
    1 arr for values   -a
    dic    -A [key]=[value]
    '
    declare -a column_names
    declare -a columns_datatype
    # myarr=($(ps -u kdride | awk '{ print $1 }'))
    column_names=awk -F ':' ' print $1 ' "$table_name metadata"
    columns_datatype=awk -F ':' ' print $2 ' "$table_name metadata"
    
    for((i=0; i<num_of_columns; i++))
    do
        dictionary[${columns_name[$i]}]=${columns_datatype[$i]} 
    done

    #print the dictionary
    # for key in "${!dictionary[@]}"
    # do
    #     echo $key ":" ${dictionary[$key]}
    # done

}

function check_column_dataType(){
    : 'if it is numeric->value dic
       if it is string -> regex, value dic
       column_name and column_datatype golbal'

    
    if [[ $column_value =~ '^[0-9]+$' ]];then
       isNum=1

    elif [[ $column_value == [a-zA-Z]* ]];then
        isString=1

    else
        echo "error it is not int neither string"
    fi
}

declare -i num_of_columns
declare -A dictionary
declare -i isNum=0
declare -i isString=0
while true
    do
    read -p "Enter table name to insert into " table_name 
    if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
        if [ -e $table_name ] ; then 
            
            echo "correct name and the table exists"
            num_of_columns=$(head -1 "$table_name metadata"| wc -w)
            auto_incremented_field
            insert_records
            break
        
        else 
            echo "Sorry it's not existed please, create a new table  "
            break
        fi

    else
            echo " Error in the table name "
    fi
    done