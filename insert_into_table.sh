#!/usr/bin/bash


   
flag=0

function auto_incremented_field(){

    # echo "the tables columns: "
    # head -1 "$table_name metadata" 
    unique_field=0

    
    if [ -s $table_name ]; then
        unique_field=$(tail -1 $table_name| cut -d : -f 1)
        ((unique_field=$unique_field+1))
        echo -n "$unique_field":"" >> $table_name
    else
        unique_field=1
        echo -n "$unique_field":"">> $table_name
    fi
}


function insert_record(){

    make_nameTypes_nameConstraints_dictionaries

    auto_incremented_field

    echo $num_of_columns
    for((i=0; i<num_of_columns; i++))
    do
        read -p "enter the column name: " column_name
        if [[ $column_name == +([a-zA-Z0-9_-]) ]] && [[ $column_name == [a-zA-Z]* ]];then
            isFound=$(grep $column_name "$table_name metadata")
            if [[ $isFound ]];then
                validate_values
                if [[ $flag == 1 ]]; then
                    echo -n "$column_value"":">> $table_name
                    echo "the value is stored successfully"
                else
                    echo "the data types are not matched"
                    break
                fi
                
            else
                echo "No column with such name"
            fi
        else
            echo "Sorry, error in the table name"
        fi
        
    done
    echo -n -e "\n"  >> $table_name

    
}


function make_nameTypes_nameConstraints_dictionaries(){


    
    IFS=$'\n' read -d '' -r -a lines < "$table_name metadata"
    
    for i in "${!lines[@]}"
    do
        IFS=':' read -r -a column <<< "${lines[i]}"
        col_names[$i]=${column[0]}
        col_types[$i]=${column[1]}
        col_constraints[$i]=${column[2]}
    done

        for ((i=0; i<num_of_columns; i++))
        do
            name_type[${col_names[$i]}]=${col_types[$i]} 
        done

        for ((i=0; i<num_of_columns; i++))
        do
            name_constraint[${col_names[$i]}]=${col_constraints[$i]} 
        done

    # for key in "${!name_type[@]}"
    # do
    #     echo $key ":" ${name_type[$key]}
    # done

    # echo "***************************"
    # for key in "${!name_constraint[@]}"
    # do
    #     echo $key ":" ${name_constraint[$key]}
    # done
}




function validate_values(){

    
    read -p "Enter a value for $column_name: " column_value
    if [[ ${name_type[$column_name]} == "int" ]]; then
        if  [[ $column_value =~ ^[0-9]+$ ]]; then
            flag=1
            
        else
            echo "it's not an integer"
            flag=0
        fi
    elif [[ ${name_type[$column_name]} == "string" ]];then
        if [[ $column_value == [a-zA-Z]* ]]; then
            flag=1
        else
            echo "it's not a string"
            flag=0
        fi
    fi
    #-------------------------------------------------
  
    

        #     # declare -a column_names
    #     # declare -a columns_datatype
    #     #declare -A columns

    #     isNum=0
    #     isString=0

    #     IFS=$'\n' read -d '' -r -a lines < "$table_name metadata"

    #     for i in "${!lines[@]}"
    #     do
    #         IFS=':' read -r -a column <<< "${lines[i]}"
    #         column_name=${column[0]}
    #         column_datatype=${column[1]}
    #         column_constraint=${column[2]}

}     

 #-------------------------------------


declare -a col_names
declare -a col_types    
declare -a col_constraints
declare -A name_type
declare -A name_constraint
    #-------------------------------

function main(){

    while true
    do
    read -p "Enter table name to insert into: " table_name 
    if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
        if [ -e $table_name ] ; then 
            
            echo "correct name and the table exists"
            num_of_columns=$(wc -l "$table_name metadata" | cut -c1)
            insert_record
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